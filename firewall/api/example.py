#!/usr/bin/env python3
from SystemController import System

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

import json

def main():
    # OPNsense の API エンドポイント
    base_url = "https://192.168.122.99"

    # API Key / Secret を使う場合
    # OPNsense の API 認証は "Bearer <key>:<secret>" 形式

    key = "Ggh9xYmXhG8Ow+RS5JKiu2394SdgdMNSsIj1KlrQfE/zQo57Oco0ZpvuiDrGuTmS"
    secret = "6a1b87f9546c0388ed90f80912cdf24c60502e761505ea409575e2fb22e38b78"
    api_key = "{0}:{1}".format(key, secret)

    api = System(base_url, api_key=api_key)

    #print("=== System Status ===")
    r = api.status()
    #print("Status code:", r.status_code)
    #print("Response:", r.text)
    print(json.dumps(r.json()))

    #print("\n=== Dismiss Status ===")
    #r = api.dismissstatus()
    #print("Status code:", r.status_code)
    #print("Response:", r.text)

    # 以下は本当にルーターを再起動・停止するので注意
    # コメントアウトしてあります

    # print("\n=== Reboot System ===")
    # r = api.reboot()
    # print("Status code:", r.status_code)
    # print("Response:", r.text)

    # print("\n=== Halt System ===")
    # r = api.halt()
    # print("Status code:", r.status_code)
    # print("Response:", r.text)

if __name__ == "__main__":
    main()

