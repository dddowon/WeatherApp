# 날씨 앱
openWeatherMap API를 사용한 애플 날씨 앱 따라 만들기 프로젝트 입니다.

## 개요
스토리보드 없이 코드로 진행한 프로젝트 입니다.

### Model
<b>Protocol</b>
  - `network` : 위도와 경도 앱 키를 프로퍼티로 받기위한 프로토콜입니다.

<b>WeatherAPI</b>
  - `WeatherData` : 날씨 API를 파싱하기 위한 데이터 구조 모델
  - `Current` : 현재 날씨 데이터 구조 모델
  - `Hourly` : 시간당 날씨 데이터 구조 모델
  - `Daily` : 요일당 날씨 데이터 구조 모델
  - `Weather` : 날씨의 아이콘 데이터 구조 모델
  - `Temp` : 최고 온도와 최소 온도 데이터 구조 모델

### Controller
한 화면으로 이루어져 있는 날씨 앱으로 extension을 활용하여 한 viewcontroller에 구현하였습니다.

- `NetWorkController` : network 프로토콜 위도 경도 프로퍼티에 locationManager를 활용해 위도 경도, 또 appKey를 받아와 Alamofire 데이터 파싱 진행

- `ViewController` : 앱의 메인 뷰컨으로 현재 위치의 위도와 경도를 받아내는 `CLLocationManager()` 그리고 `HourlyViewController`, `DailyViewController` 등이 선언

- `HourlyViewController` : ViewController에서 선언한 `HourlyCollectionView`의 `UICollectionViewDiffableDataSource` 데이터소스를 정해주는 컨트롤러
  - `HourlyCollectionViewCell` : `HourlyCollectionView`의 셀 구현 
  - <img src="https://user-images.githubusercontent.com/87158656/218922245-c08763df-a1d6-4414-ba30-b06e22babccc.gif" width="50%">
- `DailyViewController` : ViewController에서 선언한 `DailyCollectionView`의 `UICollectionViewDiffableDataSource` 데이터소스를 정해주는 컨트롤러
  - `HourlyCollectionViewCell` : `DailyCollectionView`의 셀 구현 
  - <img src="https://user-images.githubusercontent.com/87158656/218923319-5fd47fb3-2af8-49c5-8d5a-22ed003fc8cc.gif" width="50%">


### 전체화면
<img src="https://user-images.githubusercontent.com/87158656/218679050-91f0a4e9-5375-4474-898f-88071ef1412b.png" width="30%">
