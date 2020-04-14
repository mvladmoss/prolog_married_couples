% Проверка на валидность 
legal(CL,ML,CR,MR) :- 
ML>=0, CL>=0, MR>=0, CR>=0, 
(ML>=CL ; ML=0), 
(MR>=CR ; MR=0). 

% Возможные ходы 
move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):- 
MR2 is MR+2, 
ML2 is ML-2, 
legal(CL,ML2,CR,MR2). 

move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):- 
CR2 is CR+2, 
CL2 is CL-2, 
legal(CL2,ML,CR2,MR). 

move([CL,ML,left,CR,MR],[CL2,ML2,right,CR2,MR2]):- 
CR2 is CR+1, 
CL2 is CL-1, 
MR2 is MR+1, 
ML2 is ML-1, 
legal(CL2,ML2,CR2,MR2). 

move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):- 
MR2 is MR+1, 
ML2 is ML-1, 
legal(CL,ML2,CR,MR2). 

move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):- 
CR2 is CR+1, 
CL2 is CL-1, 
legal(CL2,ML,CR2,MR). 

move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):- 
MR2 is MR-2, 
ML2 is ML+2, 
legal(CL,ML2,CR,MR2). 

move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):- 
CR2 is CR-2, 
CL2 is CL+2, 
legal(CL2,ML,CR2,MR). 

move([CL,ML,right,CR,MR],[CL2,ML2,left,CR2,MR2]):- 
CR2 is CR-1, 
CL2 is CL+1, 
MR2 is MR-1, 
ML2 is ML+1, 
legal(CL2,ML2,CR2,MR2). 

move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):- 
MR2 is MR-1, 
ML2 is ML+1, 
legal(CL,ML2,CR,MR2). 

move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):- 
CR2 is CR-1, 
CL2 is CL+1, 
legal(CL2,ML,CR2,MR). 


% Рекурсивный вызов 
% На каждом этапе добавляем переход [CL3,ML3,B3,CR3,MR3] в Explored, пару [[CL3,ML3,B3,CR3,MR3],[CL1,ML1,B1,CR1,MR1]] в MovesList и продолжаем поиск от [CL3,ML3,B3,CR3,MR3] 
path([CL1,ML1,B1,CR1,MR1],[CL2,ML2,B2,CR2,MR2],Explored,MovesList) :- 
move([CL1,ML1,B1,CR1,MR1],[CL3,ML3,B3,CR3,MR3]), 
not(member([CL3,ML3,B3,CR3,MR3],Explored)), 
path([CL3,ML3,B3,CR3,MR3],[CL2,ML2,B2,CR2,MR2],[[CL3,ML3,B3,CR3,MR3]|Explored],[ [[CL3,ML3,B3,CR3,MR3],[CL1,ML1,B1,CR1,MR1]] | MovesList ]). 

% Если входное значение равно желаемому, то выводим полученный путь 
path([CL,ML,B,CR,MR],[CL,ML,B,CR,MR],_,MovesList):- 
output(MovesList). 

% Вывод пути 
output([]) :- nl. 
output([[A,B]|MovesList]) :- 
output(MovesList), 
write(B), write(' -> '), write(A), nl. 

% Функция поиска 
findpath() :- 
Start = [3,3,left,0,0], 
Goal = [0,0,right,3,3], 
path(Start,Goal,[Start],[]).