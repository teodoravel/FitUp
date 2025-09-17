Техничка документација за FitUp!
Flutter фитнес апликација по предметот Мобилни Информациски Системи
Теодора Велјаноска 223075 и Ана Саздова 225121

https://github.com/teodoravel/FitUp
https://www.figma.com/design/9LcjcsWq0fhzrLrWeRvk3f/FitUp?node-id=0-1&p=f

 Преглед на архитектурата
FitUp! е мобилна фитнес апликација развиена во Flutter која користи Node.js backend со PostgreSQL база на податоци. Апликацијата овозможува корисниците да прегледуваат вежби, закажуваат тренинзи, управуваат со омилени содржини и следат фитнес активности, теретани и тренери.

Употребени технологии:
Frontend: Flutter (Dart) со Material Design компоненти
Backend: Node.js со Express.js framework
База на податоци: PostgreSQL со DBeaver за управување
HTTP комуникација: Flutter http пакет за REST API повици
Состојба на податоци: Flutter setState() со StatefulWidget

Менаџирање на состојбата на податоците
Апликацијата ја користи Flutter's вградена setState() функционалност за локално управување со состојбата. Постои UserSession класа (lib/user_session.dart) која чува информации за најавениот корисник во меморија, вклучувајќи userId, fullName, gender, dob, height_cm и weight_kg. За трајно зачувување се користи shared_preferences пакетот за сесии и кеширање на податоци.

Работа со податоци (API, Database)
Извор на податоци: PostgreSQL база на податоци пристапена преку Node.js REST API
API комуникација: HTTP GET/POST/PUT/DELETE барања од Flutter кон Express сервер
Табели во базата: users, workouts, exercises, workout_exercises, workout_schedules, user_favorites, gyms, trainers, equipment, workout_equipment
Податочен проток: Flutter компонента → HTTP барање → Node.js endpoint → PostgreSQL упит → JSON одговор → UI ажурирање


Интеграција на веб сервис
Апликацијата интегрира сопствен Node.js REST API сервер кој работи на localhost:3000. Серверот обезбедува следниве endpoints:
- `/api/login` и `/api/register` за автентикација
- `/api/favorites/toggle` за управување со омилени
- `/api/workout/:workoutName/:difficulty` за детали за вежби
- `/api/upcoming-workouts/:userId` за закажани тренинзи
- `/api/schedule-workout` за креирање распоред
- `/api/gyms` и `/api/trainers` за фитнес центри и тренери

Автентикација / Авторизација
Системот користи основна email/password автентикација. Корисничките податоци се зачувуваат во users табелата со hashed_password поле. По успешна најава, корисничките информации се чуваат во UserSession класата и shared_preferences за персистентност. Секое API барање што бара автентикација го праќа userId како параметар за валидација.

Custom UI елементи
Апликацијата содржи неколку прилагодени UI компоненти:
- Workout карти со градиент позадини и детални информации
- Heart favorite копчиња кои менуваат боја при клик (црвено за омилени)
- Прилагодени навигациски барови со икони и лабели
- Gradient контејнери за визуелна привлечност
- Custom форми за регистрација и најава со валидација
- Workout schedule карти кои прикажуваат датум, време и детали


Навигација
Навигацијата се имплементира преку Navigator.pushNamed() системот на Flutter со именувани рути. Главните страници вклучуваат:
- StartPage/IntroductionPage - почетен екран со слика
- HomePage - главен dashboard со upcoming workouts
- WorkoutDetailsPage - детали за специфични вежби
- FavoritesPage - листа на омилени содржини
- AddWorkoutSchedulePage - закажување тренинзи
- ProfilePage - кориснички профил и поставки

Структура на базата на податоци
Базата содржи 10 главни табели со релации:
- users - кориснички профили со лични податоци
- workouts - вежби со тежина, времетраење и калории
- exercises - поединечни вежби со инструкции
- workout_exercises - врска помеѓу workouts и exercises
- workout_schedules - закажани тренинзи за корисници
- user_favorites - омилени workouts, gyms, trainers
- gyms - фитнес центри со локации
- trainers - тренери со рејтинзи
- equipment - опрема потребна за вежби
- workout_equipment - врска помеѓу workouts и equipment

 Функционалности
Основни функции:
- Регистрација и најава на корисници
- Прегледување workout библиотека по категории (Fullbody, Upperbody, Lowerbody, Outdoor)
- Детални информации за вежби со инструкции и потребна опрема
- Закажување тренинзи со датум и време
- Управување со омилени workouts, gyms и trainers
- Кориснички профил со лични податоци

Напредни функции:
- Автоматско пресметување на времетраење на workout врз основа на вежбите
- Филтрирање по тежина (Beginner, Intermediate, Advanced)
- Upcoming workouts dashboard со real-time податоци
- Favorites систем со toggle функционалност
- Responsive UI дизајн со Material Design


Апликацијата претставува комплетно решение за фитнес управување со модерна архитектура и интуитивен кориснички интерфејс.
