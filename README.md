# Неофициальный клиент CityDrive

Данное приложение не несёт цели навредить репутации и информационной безопасности сервиса СитиДрайв. По первой же просьбе представителей каршеринга приложение будет убрано из публичного доступа.

Для iOS 17 и выше.

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
    <span><img src="img/1.png" style="width:200px;"></span>
    <span><img src="img/2.png" style="width:200px;"></span>
</div>

## Структура проекта

```
CityDrive
├── NetworkLayer
│   ├── Endpoint
│   │   └── ...
│   ├── Service
│   │   ├── NetworkRouter <- interface for router
│   │   ├── EndpointType  <- interface for endpoint
│   │   └── ...
│   ├── Manager
│   │   └── ...
│   ├── Encoding          <- json and url parameters encoders
│   │   └── ...
│   └── Model             <- response and request models
│       └── ...
├── View
│   └── ...
├── Model
│   └── ...
├── ViewModel
│   └── ...
├── MapView
├── CityDriveApp
└── ...                   <- Extentions and Resourses
```

## Технологии

- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Сетевой слой](https://habr.com/ru/articles/443514/)
- [Безопасность токена](https://github.com/jrendel/SwiftKeychainWrapper)
