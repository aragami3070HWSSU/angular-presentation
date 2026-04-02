#import "@preview/touying:0.5.5": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import themes.university: *
#import "@preview/numbly:0.1.0": numbly

#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none, display-icon: false, display-name: false)
#show: university-theme.with(aspect-ratio: "16-9", header-right: "", config-info(title: [AngularJS], author: [Смирнов Егор 351гр.]))

#set heading(numbering: none)
#show heading.where(level: 1): set heading(numbering: numbly("{1}", default: "1.1"))

#title-slide()

#set text(size: 22pt)
#let slide_center(content) = slide(align(center)[
  #content
])

= AngularJS
== Что такое AngularJS?
#slide(grid(columns: (1fr,0.1fr, 1fr))[
  AngularJS --- это open-source JavaScript-фреймворк созданный компанией Google
  в 2010. Он позволяет создавать SPA с использованием MVC архитектуры,
  двусторонней привязкой данных, в которых контент динамически обновляется без
  полной перезагрузки страницы.
][][
  #image("images/angular_logo.png")
])

== Дикий Frontend до AngularJS
#slide(grid(columns: (0.9fr,0.1fr, 0.9fr))[
  #set text(size: 20pt)
  #v(30pt)
  ```html
<input id="nameInput">
<p id="output"></p>

<script>
  $('#nameInput')
    .on('input', function() {
    $('#output')
        .text($(this).val());
  });
</script>
  ```
][][
  #v(100pt)
  - вручную навешивали обработчик
  - сами обновляем DOM
  - много кода
])

#slide(grid(columns: (0.9fr,0.1fr, 0.9fr))[
  #set text(size: 20pt)
  #v(100pt)
  ```html
<div ng-app="">
  <input ng-model="name">
  <p>{{name}}</p>
</div>
  ```
][][
  #v(100pt)
  - нет явной логики обновления DOM
  - биндинг сам все подставляет
  - код короче, чище, проще
])

= Основные концепции
== Основные концепции
#slide([
  + Паттерн MVC в браузере
  + Система шаблонов, которая расширяет HTML пользовательскими атрибутами
    (директивами), такими как ng-model, ng-repeat и ng-click
  + Two-way data binding --- двусторонняя привязка данных, которая
    автоматически синхронизирует данные между объектами JS и представлением (HTML)
  + DI --- внедрение зависимостей, которое управляет тем как различные части
    приложения получают необходимые им сервисы.
  + Routing для создания SPA с несколькими представлениями.
])

== Паттерн MVC в браузере
#slide(grid(columns: (1fr, 1fr))[
  - Model: Простые объекты JavaScript, содержащие данные приложения.
  - View: HTML-шаблоны с директивами AngularJS
  - Controller: JavaScript-функции, которые настраивают модель и обеспечивают
    поведение представления.
][
  #image("images/mvc.png")
])

== Директивы
#slide[
AngularJS стал пионером декларативного программирования для пользовательских
интерфейсов. Вместо написания императивного кода, описывающего  пошаговое
создание интерфейса, вы объявляете,  как  должен выглядеть интерфейс:
  ```html
<!-- Декларативное описание: описывает, что нужно показать -->
<div ng-repeat="user in users">
  <h3>{{user.name}}</h3>
  <p>{{user.email}}</p>
</div>
  ```
]

#slide[
  Фреймворк поставляется с десятками встроенных директив, например:
    - ng-repeat: Цикл по массивам для генерации повторяющихся HTML-элементов
    - ng-if: Условное отображение/скрытие элементов
    - ng-class: Динамическое применение CSS-классов
    - ng-click: Обработка событий клика

  Декларативный стиль уменьшил сложность кода и улучшил его сопровождение.
]

== Двусторонняя привязка данных
#slide(grid(columns: (0.9fr,0.1fr, 0.9fr))[
  #set text(size: 20pt)
  *jQuery:*
  ```html
<input id="nameInput">
<p id="output"></p>

<script>
  $('#nameInput')
    .on('input', function() {
    $('#output')
        .text($(this).val());
  });
</script>
  ```
][][
  *AngularJS:*
  ```html
<div ng-app="">
  <input ng-model="name">
  <p>{{name}}</p>
</div>
  ```
])

== Система внедрения зависимостей
#slide[
  #grid(columns: (0.8fr, 0.01fr, 1fr))[
    ```js
// Без DI
function MyController() {
  this.userService =
    new UserService();
}
    ```

  ][][
    ```js
// С использованием DI
app.controller('MainCtrl', function($scope, UserService) {
  // UserService предоставляется автоматически
  $scope.users =
    UserService.getUsers();
});
    ```
  ]
  Этот подход значительно улучшил тестируемость. В тестах вместо реальных
  сервисов внедряются фиктивные сервисы, что позволяет проводить изолированное
  модульное тестирование без зависимостей от бэкэнда.
]

== Routing
AngularJS включал в себя ngRoute (позже замененный на ui-router) для создания
одностраничных приложений (SPA). Это позволило разработчикам создавать
многостраничные приложения, которые по ощущениям напоминали традиционные
многостраничные сайты, но загружались мгновенно и работали в автономном режиме
```js
app.config(function($routeProvider) {
  $routeProvider
    .when("/", { templateUrl : "main.htm" })
    .when("/red", { templateUrl : "red.htm" })
}
```

== Почему это было прорывом?
#slide[
  - AngularJS позволил писать структурированный frontend
  - SPA стал стандартом
  - Стало меньше прямой работы с DOM
  - Многие популярные сейчас фреймворки вдохновлены Angular-ом и пытались
    закрыть его проблемы
]

== Проблемы
#slide([
  - Проблема «узкого места» в цикле обработки дайджестов. Каждый цикл обработки
    дайджестов должен проверять каждого наблюдателя, что приводит к
    масштабируемости производительности O(n)
  - `$scope` становился "god object-ом" --- общий объект между View и Controller
    => в него складывается все (данные, функции, состояния) $->$ трудно читать
    и рефакторить код, высокая вязность
  - Много неявного поведения => сложно понять когда и сколько компонентов
    затронет обновление значения
    ```html
<input ng-model="name">
<p>{{name}}</p>
    ```
  - Отсутствие серверного рендеринга
  - Производительность на мобильных устройствах
])

== AngularJS vs Angular
#slide([
  #table(
    columns: 3,
    [*Аспект*], [*AngularJS*], [*Angular 2+*],
    [Язык], [js], [ts],
    [Архитектура], [MVC с двусторонним связыванием], [Копонентный подход с
      однонаправленным потоком данных],
    [Производтиельность], [Цикл обработки дайджестов], [Обнаружение изменений по
    зонам (быстрее)]
  )
  Таким образом решилась некоторые проблемы:
  - производительности за счет перехода на более оптимизированный механизм
    отслеживания изменений.
  - код стал более предсказуемым
])

#slide([
```js
@Component({
  selector: 'app-user',
  template: `
    <input [value]="user.name" (input)="onInput($event)">
    <p>{{user.name}}</p>
  `
})
export class UserComponent {
  user = { name: 'Alice' };
  onInput(event: Event) { this.user.name =  (event.target as HTMLInputElement).value; }
}
```
])

== Сравнение с React
#slide([
  #grid(columns: (0.7fr, 0.1fr, 1fr))[
    Пример AngularJS
    ```html
<input ng-model="name">
    ```
  ][][
  Пример React
    ```js
const [name, setName] = useState("");
<input onChange={
  (e)=>setName(e.target.value)}/>
<p>{name}</p>
    ```
  ]
  Решаются проблемы:
  - «узкого места» в цикле обработки дайджестов (сравнивая новый Virtural DOM с
    предыдущим, обновляя только нужные части)
  - неявного поведения (сам контролируешь процесс обновления)
])

#slide([
  #grid(columns: (0.7fr, 0.1fr, 1fr))[
    Пример AngularJS
    ```html
$scope.user = {...};
$scope.orders = [...];
$scope.save = function() {};
    ```
  ][][
  Пример React
    ```js
const [user, setUser] = useState(null);
const [orders, setOrders] = useState([]);
function save() { }
    ```
  ]
  Решает проблему раздутого `$scope`, т.к.:
  - данные локальны
  - каждый компонент изолирован
  - нет глобального scope
])


== Заключение
#slide([
  - AngularJS был важным этапом развития frontend разработки и  превнес много
    полезных технологий
  - Популязировал SPA
  - Считается легаси, т.к. прекратили поддержку.
  - Требует миграции.
])
