# -*- coding: utf-8 -*-
"""
测试 NetForum 三个修复的 Playwright 脚本
"""
import asyncio
import os
import sys
from pathlib import Path

from playwright.async_api import async_playwright

BASE = "http://localhost:8080/netforum"
SHOT_DIR = Path(r"D:\虚拟机\期末考核\NetForum\screenshots")
SHOT_DIR.mkdir(parents=True, exist_ok=True)


async def shot(page, name):
    """截图并打印页面 URL 和标题"""
    p = SHOT_DIR / f"{name}.png"
    await page.screenshot(path=str(p), full_page=True)
    print(f"  ✓ 截图: {p}  url={page.url}")


async def run():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        ctx = await browser.new_context(viewport={"width": 1366, "height": 900})
        page = await ctx.new_page()

        # ==========================================================
        # 修复 3：底部导航栏 - 使用指南/社区公约/联系我们
        # ==========================================================
        print("\n[测试3] 底部导航栏静态页面")
        await page.goto(f"{BASE}/", wait_until="networkidle")
        await shot(page, "01_home_with_new_footer")

        # 点击"使用指南"
        await page.click("text=使用指南")
        await page.wait_for_load_state("networkidle")
        title = await page.title()
        body_text = await page.locator("body").inner_text()
        print(f"  使用指南 - 标题: {title}")
        assert "使用指南" in title or "使用指南" in body_text, "使用指南 页面未加载"
        await shot(page, "02_footer_help")

        # 点击"社区公约"
        await page.goto(f"{BASE}/page/agreement", wait_until="networkidle")
        title = await page.title()
        body_text = await page.locator("body").inner_text()
        print(f"  社区公约 - 标题: {title}")
        assert "社区公约" in title or "社区公约" in body_text
        await shot(page, "03_footer_agreement")

        # 点击"联系我们"
        await page.goto(f"{BASE}/page/contact", wait_until="networkidle")
        title = await page.title()
        body_text = await page.locator("body").inner_text()
        print(f"  联系我们 - 标题: {title}")
        assert "联系我们" in title or "联系我们" in body_text
        await shot(page, "04_footer_contact")

        # ==========================================================
        # 登录 admin (admin / admin123)
        # ==========================================================
        print("\n[登录] admin 管理员")
        await page.goto(f"{BASE}/user/login", wait_until="networkidle")
        await page.fill("input[name='username']", "admin")
        await page.fill("input[name='password']", "admin123")
        await shot(page, "05_login_filled")
        await page.click("button[type='submit']")
        await page.wait_for_load_state("networkidle")
        print(f"  登录后 url: {page.url}")
        # 检查是否登录成功（看是否有用户名/admin标签）
        body = await page.locator("body").inner_text()
        assert "admin" in body, "登录失败 - 未找到 admin 用户名"
        await shot(page, "06_after_admin_login")

        # ==========================================================
        # 修复 1：管理员编辑非本人帖子（以前跳首页）
        # ==========================================================
        print("\n[测试1] 管理员编辑非本人帖子")
        # 找一个非 admin 发的帖子 - id=3 是 user_id=1 (admin)，找一个 user_id!=1 的
        # post id=3 是 admin 发的，id=4 是 user_id=5 发的
        # 我们用 id=4
        target_post = 4
        await page.goto(f"{BASE}/post/edit?id={target_post}", wait_until="networkidle")
        body = await page.locator("body").inner_text()
        url = page.url
        print(f"  编辑帖子 id={target_post} 后 url: {url}")
        # 修复后应该留在 /post/edit?id=4，而不是被重定向到首页 /
        assert "edit" in url.lower(), f"管理员编辑帖子失败，被踢到 {url}"
        assert "首页" not in body[:200] or url != f"{BASE}/", "管理员编辑帖子被重定向到首页"
        await shot(page, "07_admin_edit_post_not_own")

        # 修改标题进行实际更新
        title_input = page.locator("input[name='title']")
        if await title_input.count() > 0:
            new_title = "管理员测试编辑-原标题"
            await title_input.fill(new_title)
            # 提交表单
            await page.click("button[type='submit']")
            await page.wait_for_load_state("networkidle")
            body_after = await page.locator("body").inner_text()
            print(f"  提交编辑后 url: {page.url}")
            print(f"  提交编辑后包含新标题: {new_title in body_after}")
            await shot(page, "08_admin_edit_post_result")

        # ==========================================================
        # 修复 2：管理员删除带回复的帖子
        # ==========================================================
        print("\n[测试2] 管理员删除带回复的帖子")
        # 找一个有回复的非 admin 帖子
        # id=31 有 6 个回复，user_id=7 (非 admin)
        target_post_for_delete = 31
        await page.goto(f"{BASE}/post/detail?id={target_post_for_delete}", wait_until="networkidle")
        body = await page.locator("body").inner_text()
        print(f"  详情页 url: {page.url}")
        print(f"  详情页含'回复'字样: {'回复' in body}")

        # 设置响应拦截：删除请求应该重定向，不应该返回 JSON
        delete_response = {"status": None, "headers": None}

        async def handle_response(response):
            if "post/delete" in response.url:
                delete_response["status"] = response.status
                delete_response["headers"] = response.headers
                print(f"  拦截到 /post/delete 响应: status={response.status} url={response.url}")
                if response.status == 200:
                    try:
                        body_text = await response.text()
                        print(f"  /post/delete 响应体 (前200字符): {body_text[:200]}")
                        if body_text.strip().startswith("{") or "删除失败" in body_text:
                            print(f"  ⚠ 警告: 删除失败时返回了原始响应而非重定向")
                    except Exception as e:
                        print(f"  读取响应体失败: {e}")

        page.on("response", handle_response)

        # 点击删除按钮（在 post detail 页）
        delete_btn = page.locator("button:has-text('删除')")
        if await delete_btn.count() > 0:
            # 自动确认 dialog
            page.once("dialog", lambda dialog: dialog.accept())
            await delete_btn.first.click()
            await page.wait_for_load_state("networkidle")
            url_after = page.url
            body_after = await page.locator("body").inner_text()
            print(f"  删除后 url: {url_after}")
            # 验证：
            # 1. 不应该显示 JSON 源码
            # 2. 应该跳转到板块页
            # 3. 或者显示 flash 错误
            if "{" in body_after[:300] and "success" in body_after[:300]:
                print(f"  ✗ 失败: 浏览器显示了 JSON 源码!")
                await shot(page, "09_delete_FAIL_json_shown")
            elif "board/detail" in url_after or "/" == url_after.split("netforum")[-1]:
                print(f"  ✓ 删除成功跳转到板块页")
                await shot(page, "09_delete_success")
            else:
                print(f"  ? 删除后 URL: {url_after}")
                await shot(page, "09_delete_unexpected")
        else:
            print("  ✗ 未找到删除按钮")
            await shot(page, "09_delete_no_button")

        # ==========================================================
        # 验证帖子真的被删除了
        # ==========================================================
        # 再次访问帖子详情，应该跳转到首页或显示不存在
        await page.goto(f"{BASE}/post/detail?id={target_post_for_delete}", wait_until="networkidle")
        url_now = page.url
        body_now = await page.locator("body").inner_text()
        print(f"  重新访问被删帖子 - url: {url_now}")
        # post 删了应该跳到首页
        if "post/detail" in url_now and "该帖已删除" not in body_now and "不存在" not in body_now and "404" not in body_now:
            print(f"  ⚠ 警告: 被删帖子的详情页还能正常访问 - 可能删除没成功")
            await shot(page, "10_post_still_exists")
        else:
            print(f"  ✓ 帖子已被删除，重定向到: {url_now}")
            await shot(page, "10_post_deleted")

        # ==========================================================
        # 首页最终截图
        # ==========================================================
        await page.goto(f"{BASE}/", wait_until="networkidle")
        await shot(page, "11_final_home")

        await browser.close()
        print("\n========== 所有测试完成 ==========")


if __name__ == "__main__":
    asyncio.run(run())
