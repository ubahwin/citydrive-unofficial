# Неофициальный клиент CityDrive

<div align="center">
    <img src="img/image_selfie.png" alt="AppIcon" height="200">
</div>

![](https://img.shields.io/badge/iOS-17%2B-green?logo=apple)
![](https://img.shields.io/badge/Swift%205.9-FA7343?style=flat&logo=swift&logoColor=white)

> Данное приложение не несёт цели навредить репутации и информационной безопасности сервиса СитиДрайв. По первой же просьбе представителей каршеринга приложение будет убрано из публичного доступа.

## Приложение

> Цвета соответствуют [brendbook](https://vc.ru/citydrive/320352-keys-sitidrayv-kak-brendu-s-mnogoletney-istoriey-za-mesyac-obnovit-aydentiku-i-dizayn-vseh-poverhnostey) СитиДрайв

Более удобная версия клиента, по сравнению с оригинальным СитиДрайв
* Нет бургер-меню – используется таббар
* История поездок вынесена явно


#### Вход

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/0.png" style="width:200px;">
  <img src="img/0.1.png" style="width:200px;">
</div>

#### История поездок

* Возможность более подробно изучить каждую поездку – все события, всё про автомобиль, рейтинг и тд
* Сумму с поездки можно разделить между участниками поездки

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/2.png" style="width:200px;">
  <img src="img/2.1.png" style="width:200px;">
</div>

#### Карта

* Карта от Apple, взамен 2GIS
* Можно проложить маршрут до автомобиля бесшовно – прямо на карте
* Плашка с информацией об автомобиле и красивый гос. номер
* Пины соответствуют пинам в оригинальном СитиДрайв

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/1.png" style="width:200px;">
  <img src="img/1.1.png" style="width:200px;">
</div>

#### Настройки

* Есть темная тема
* Возможность выбора города, где показывать автомобили
* Тип карты: со спутника или стандарт
* Функция "Водитель платит меньше" – если у вас принято делить стоимость поездки, то включив эту функцию доля водителя уменьшится на указанный процент и распределяется между всеми участниками поездки.
* Информация о пользователе и выход из аккаунта

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/3.png" style="width:200px;">
  <img src="img/3.1.png" style="width:200px;">
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
└── ...                   <- Extensions and Resourses
```

## Технологии и инструменты

- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [MapKit](https://developer.apple.com/documentation/mapkit/mapkit_for_swiftui)
- [Сетевой слой](https://habr.com/ru/articles/443514/)
- [Безопасность токена](https://github.com/jrendel/SwiftKeychainWrapper)

- [Postman](https://www.postman.com/)
- [Proxyman](https://proxyman.io/)
- [SSL Pinning](https://gist.github.com/UbahWin/fd4ccec403e41de3918df2f863bd8e91)
- [SwiftLint](https://github.com/realm/SwiftLint)
