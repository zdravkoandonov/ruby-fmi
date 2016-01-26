REPOSITORY = 'http://github.com/zdravkoandonov/ruby-retrospective-2015-1'

# 1. Понякога е по-удобно да се използва hash вместо case. В случая на първа
#   задача използвайки hash, можем да променяме по-лесно точността на резултата -
#   само на едно място.
# 2. Вместо да прилагаме деструктивна функция над копие на обекта можем просто да
#   използваме недеструктивна функция с подобно действие -
#   обикновено в ruby има такава
# 3. position_ahead_of_snake не е нужно да знае къде точно в масива на змията се
#   намира главата на змията - създаваме нова функция за главата на змията и
#   подаваме на position_ahead_of_snake само главата на змията
# 4. splat-ваме head и direction на две променливи - за x и y координатите -
#   с цел по-лесно четим код - така вече става ясно, че head[0] е x координатата и
#   head[1] е y координатата (аналогично и за direction)
# 5. В Ruby може да е по-лесно да се използва n**0.5 за коренуване
#   вместо Math.sqrt(n) - така по-лесно можем да сменим степента, ако искаме друг корен
# 6. По лесно и бързо е вместо while цикъл да се използва енумератор от числа
#   генериран например като 2.upto(self**0.5))
# 7. На мястото на while цикъл за обхождане на енумератор може да се използва
#   готова функция като all?, която да провери дадено условие за елементите му
# 8. В Ruby може да се използва безкраен lazy енумератор, от който да селектираме
#   само елементите, които ни трябват и след това да вземем само колкото ни трябват
# 9. Много по-лесно е вместо да пишем цял блок от рода на { |item| item.prime? },
#   да използваме &:prime?, което превръща prime? в блок, който можем да подадем
#   на някоя функция
# 10. Вместо да yield-ваме всеки елемент на масив можем да приемаме като аргумент
#   на функцията блока, който се подава и да го подаваме на each метода на масива
#   (или енумератора)
# 11. enum_for е удобен ако искаме да създадем енумератор обхождащ елементите
#   yield-вани от дадена функция
# 12. Трябва да свикна с това, че когато функция връща масив мога да го присвоя
#   на няколко променливи и той автоматично ще се splat-не.
#   Например двете групи в резултат от partition може директно да се запазят в две
#   променливи със смислени имена.
# 13. Вместо да трупам данни в масив с <<, мога да използвам map над енумератор
# 14. Изразът x = y || 0 е полезен за поставяне на стойност по подразбиране, ако
#   y в този случай е nil, и е алтернатива на fetch(-1, 0), ако y е например
#   последния елемент на масив
# 15. Много важен принцип е DRY принципът. Винаги когато трябва да копираш един
#   код на няколко места почти един и същ - създай си функция с параметър
#   променящите се данни
# 16. Функциите, които не са част от публичния интерфейс по спецификация е добре
#   да са private когато може
# 17. Всеки клас трябва да "знае" само това, което е пряко свързано с реалния
#   обект, който представя, а не всичко възможно. Например можем да добавим
#   константа в WarHand, BeloteHand и SixtySixHand
#   за големината на една ръка и в deal метода на тестетата да използваме
#   константата от класовете, представящи ръцете - в случая тестетата сами по
#   себе си не е нужно да знаят по колко карти се раздават във всяка ръка.
# 18. В методите на даден клас е добре да достъпваме полетата на този клас през
#   getter-ите им, защото ако променим представянето на полетата, getter–ите ще се
#   запазят и няма да има нужда да променяме представянето навсякъде
# 19. Ако създаваме клас като наследник на Struct.new, в него се създават доста
#   методи, които понякога може да са излишни - например явно в Struct се дефинира
#   оператор ==, който работи коректно (поне в нашия случай) -
#   сравнява всяко от полетата
# 20. Когато една и съща функционалност се използва в два различни класа, можем
#   да я изнесем във функция в общия родител - pair_of_queen_and_king? се използва
#   и в BeloteHand#belote?, и в SixtySixHand#twenty? и SixtySixHand#forty?