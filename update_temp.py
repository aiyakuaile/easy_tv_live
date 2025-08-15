#!/usr/bin/env python
import requests

# 目标地址
# TARGET_URL = "https://raw.githubusercontent.com/Guovin/iptv-api/gd/output/ipv6/result.m3u"
TARGET_URL = "https://iptv-org.github.io/iptv/countries/cn.m3u"
# 要写入的本地文件路径（项目中的temp文件）
LOCAL_FILE = "temp"


def main():
    try:
        # 发送请求获取内容（设置超时时间避免无限等待）
        response = requests.get(TARGET_URL, timeout=10)
        response.raise_for_status()  # 若请求失败（如404、500），抛出异常

        # 将内容写入本地temp文件（覆盖原有内容）
        with open(LOCAL_FILE, "w", encoding="utf-8") as f:
            f.write(response.text)

        print(f"成功将内容写入 {LOCAL_FILE}")

    except requests.exceptions.RequestException as e:
        # 捕获请求相关异常（网络错误、超时、HTTP错误等）
        print(f"请求失败：{e}")
        raise  # 抛出异常让GitHub Actions捕获，便于查看错误日志
    except IOError as e:
        # 捕获文件写入异常
        print(f"文件写入失败：{e}")
        raise

if __name__ == "__main__":
    main()