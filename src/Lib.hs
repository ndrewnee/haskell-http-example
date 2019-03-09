{-# LANGUAGE QuasiQuotes #-}
module Lib
    ( archsJSON
    , catalogsJSON
    )
where

import Text.RawString.QQ

archsJSON :: String
archsJSON = [r|
{
  "hits": [
    {
      "id": "a0000-v0.0.0",
      "schema": "https://example.com/assets/schemas/arch-v0.1.0",
      "name": "Дата рождения",
      "tags": [
        "various"
      ],
      "opts": {
        "type": "text"
      },
      "kinds": [
        {
          "type": "string",
          "free": true,
          "constraints": {
            "pattern": "^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|W([0-4]\\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\\d|[12]\\d{2}|3([0-5]\\d|6[1-6])))([T\\s]((([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)([\\.,]\\d+(?!:))?)?(\\17[0-5]\\d([\\.,]\\d+)?)?([zZ]|([\\+-])([01]\\d|2[0-3]):?([0-5]\\d)?)?)?)?$"
          }
        }
      ]
    }
  ],
  "total": 1
}
|]

catalogsJSON :: String
catalogsJSON = [r|
[
    {
        "id": "ca3db54e-b118-40f3-a541-5ff203711637",
        "category": "cashier",
        "name": "АТОЛ 77Ф",
        "desc": "",
        "targetOS": [
            "windows"
        ],
        "targetArch": [
            "386"
        ],
        "links": [
            {
                "type": "productInfo",
                "url": "http://www.atol.ru/catalog/atol-77f/"
            }
        ],
        "template": {
            "type": "group",
            "name": "",
            "arch": "",
            "content": [
                {
                    "type": "group",
                    "name": "Настройки ККМ",
                    "arch": "",
                    "content": [
                        {
                            "type": "archetype",
                            "name": "Индекс ККМ устройства",
                            "opts": {
                                "custom": "{}",
                                "type": "number"
                            },
                            "seat": "$.deviceIndex",
                            "arch": "arch002",
                            "kinds": [
                                {
                                    "type": "number",
                                    "free": true,
                                    "multi": false,
                                    "units": "",
                                    "constraints": {
                                        "min": 0,
                                        "step": 1
                                    },
                                    "default": [
                                        0
                                    ]
                                }
                            ],
                            "content": []
                        }
                    ]
                }
            ]
        }
    }
]
|]
