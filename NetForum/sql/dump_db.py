"""
导出 netforum 数据库所有表为 markdown 到 docs/database-dump.md
"""
import subprocess
import os
import json
from datetime import datetime

MYSQL = "C:/Program Files/MySQL/MySQL Server 9.5/bin/mysql.exe"
PWD = "admin123"
DB = "netforum"
OUT = "D:/虚拟机/期末考核/NetForum/docs/database-dump.md"

TABLES = ["t_user", "t_board", "t_post", "t_reply", "t_like"]


def mysql_query(sql: str) -> str:
    """Run SQL and return tab-separated output."""
    result = subprocess.run(
        [MYSQL, "-u", "root", f"-p{PWD}", "-N", "-B", "--default-character-set=utf8mb4",
         "-e", f"USE {DB}; {sql}"],
        capture_output=True, text=True, encoding="utf-8", errors="replace"
    )
    if result.returncode != 0:
        return f"ERROR: {result.stderr}"
    return result.stdout.strip()


def fetch_table_meta():
    """Return {table: [(col_name, data_type), ...]}"""
    out = mysql_query(
        "SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLUMN_COMMENT "
        "FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='netforum' "
        "ORDER BY TABLE_NAME, ORDINAL_POSITION;"
    )
    meta = {}
    for line in out.splitlines():
        parts = line.split("\t")
        if len(parts) < 4:
            continue
        tbl, col, dtype, comment = parts[0], parts[1], parts[2], parts[3]
        meta.setdefault(tbl, []).append((col, dtype, comment))
    return meta


def fetch_table_rows(table: str, limit: int = None):
    """Return list of rows, each row is a list of column values."""
    sql = f"SELECT * FROM {table}"
    if limit:
        sql += f" LIMIT {limit}"
    sql += ";"
    out = mysql_query(sql)
    if out.startswith("ERROR"):
        return []
    rows = []
    for line in out.splitlines():
        rows.append(line.split("\t"))
    return rows


def md_escape(s: str) -> str:
    if s is None:
        return ""
    s = str(s)
    return s.replace("|", "\\|").replace("\n", " ").replace("\r", "")


def main():
    meta = fetch_table_meta()
    out_lines = []
    out_lines.append("# NetForum 数据库导出")
    out_lines.append("")
    out_lines.append(f"**导出时间**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    out_lines.append(f"**数据库**: {DB}")
    out_lines.append("")

    # 总览
    out_lines.append("## 数据总览")
    out_lines.append("")
    out_lines.append("| 表 | 记录数 |")
    out_lines.append("|---|---:|")
    for t in TABLES:
        n = mysql_query(f"SELECT COUNT(*) FROM {t};")
        out_lines.append(f"| `{t}` | {n} |")
    out_lines.append("")

    # 每张表
    for t in TABLES:
        cols = meta.get(t, [])
        out_lines.append(f"## `{t}`")
        out_lines.append("")
        out_lines.append("### 表结构")
        out_lines.append("")
        out_lines.append("| 列 | 类型 | 注释 |")
        out_lines.append("|---|---|---|")
        for c, dt, cm in cols:
            out_lines.append(f"| `{c}` | {dt} | {cm or '—'} |")
        out_lines.append("")

        rows = fetch_table_rows(t)
        out_lines.append(f"### 数据 ({len(rows)} 行)")
        out_lines.append("")

        if not rows:
            out_lines.append("_空表_")
            out_lines.append("")
            continue

        col_names = [c for c, _, _ in cols]
        out_lines.append("| " + " | ".join(col_names) + " |")
        out_lines.append("|" + "|".join(["---"] * len(col_names)) + "|")
        for r in rows:
            cells = [md_escape(c) for c in r]
            out_lines.append("| " + " | ".join(cells) + " |")
        out_lines.append("")

    with open(OUT, "w", encoding="utf-8") as f:
        f.write("\n".join(out_lines))

    size = os.path.getsize(OUT)
    print(f"Written: {OUT} ({size} bytes, {len(out_lines)} lines)")


if __name__ == "__main__":
    main()
