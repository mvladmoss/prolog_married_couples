% Структура следующая [Boat, [Husband1, Wife1], [Husband2, Wife2], [Husband3, Wife3]]

move2([[H,W]|T],[[H1,W1]|T],B) :- H=B, W=B, H1 is 1-H, W1 is 1-W. % позволяет перевести одну парну
move2([X|T1],[X|T2],B) :- move2(T1,T2,B). % позволяет не зациклиться на одной паре. Т.е. если пара уже была перевезена на 
% определенный берег, то будет выбрана след пара
 
move1([[H,W]|T],[[H1,W]|T],B,1) :- H=B, H1 is 1-H. % перевозим одного мужчину
move1([[H,W]|T],[[H,W1]|T],B,2) :- W=B, W1 is 1-W. % перевозим одну женщину
move1([X|T1],[X|T2],B,Gender) :- move1(T1,T2,B,Gender). % определяем предикат для перевозки одного человека одного пола
 
move(X,Y,B) :- move2(X,Y,B). % перевозим двоих
move(X,Y,B) :- move1(X,Y,B,_). % когда перевозим одного, нам нет разницы какого человек пола
move(X,Y,B) :- move1(X,Z,B,Gender), move1(Z,Y,B,Gender). % может перевозить двух человек одного пола
 

failcondition(_,_,1,1). % выходим, когда выяснили, что чужой муж находится с чужой женой
failcondition([[X,Y]|T],Z,H,W) :- X\=Y, (Z=Y;Z=2), W=0, failcondition(T,Y,H,1). % муж с женой на разных берегах
failcondition([[Y,_]|T],Z,H,W) :- (Z=Y;Z=2), H=0, failcondition(T,Y,1,W). % находим чужого мужа для жена с предыдущей проверки
failcondition([_|T],Z,H,W) :- failcondition(T,Z,H,W). % аналогично 4 строке, да бы исключить зацикливание
 
condition(X) :- not(failcondition(X,2,0,0)). 
 
go([BX|X],[BY|Y]) :- move(X,Y,BX), condition(Y), BY is 1-BX. % пробуем перевезти, проверяем допустима ли такая перевозка, в случае успеха, меняем берег
 
res(S,E,P) :- s1(S,E,[S],P1), reverse(P1,P). %  reverse чтобы список при отображении начинался сначала, а не с конца
s1(E,E,R,R). % конечное условие поиска, когда начальное и конечное состояния совпадают
s1(S,E,R,P) :- go(S,X), not(member(X,R)), s1(X,E,[X|R],P).

% Вывод пути 
output([]) :- nl. 
output([A,B|MovesList]) :-
write(A), write(' -> '), write(B), nl, 
output(MovesList).
exec() :- S=[0,[0,0],[0,0],[0,0]], E=[1,[1,1],[1,1],[1,1]], res(S,E,X), output(X).