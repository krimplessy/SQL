Глава № 2.1 #1 	Задание № 2: Напишите запрос, позволяющий вывести все строки таблицы EXAM_MARKS, в которых предмет обучения имеет номер (SUBJ_ID), равный 12.  		SELECT *
		FROM Exam_Marks
		WHERE Subj_ID = 12;

	Задание № 14: Напишите запрос для получения списка предметов, для которых в 1-м семестре отведено более 100 часов. 

		SELECT Subj_Name
		FROM Subject
		WHERE Hour > 100 AND Semester = 1;

Глава № 2.2 #2
	Задание № 2: Напишите запрос, выбирающий данные обо всех предметах обучения, экзамены по которым сданы студентами, имеющими идентификаторы 12 и 32. 

		SELECT Subj_ID
		FROM Exam_Marks
		WHERE Student_ID IN (12, 32) AND Mark > 2;

	Задание № 11: Напишите запрос для получения списка студентов, фамилии которых начинаются на ‘Ков’ или на ‘Куз’. 
		SELECT Surname, Name
		FROM Student
		WHERE Surname LIKE 'Ков%' OR Surname LIKE 'Куз%';

Глава № 2.3: #3
		Задание № 1: Составьте запрос для таблицы STUDENT таким образом, чтобы выходная таблица содержала один столбец, содержащий последовательность разделенных символом “;” (точка с запятой) значений всех столбцов этой таблицы; при этом текстовые значения должны отображаться прописными символами (верхний регистр), т. е. быть представленными в следующем виде: 10;КУЗНЕЦОВ;БОРИС;0;БРЯНСК; 8.12.1987;10. 

		SELECT CONCAT_WS(';', Student_ID, UPPER(Surname), UPPER(Name), Stipend, Kurs, UPPER(City), DATE_FORMAT(Birthday, '%d.%m.%Y'), Univ_ID)
		FROM Student;

	Задание № 2: Составьте запрос для таблицы STUDENT таким образом, что- бы выходная таблица содержала всего один столбец в следующем виде: Б.КУЗНЕЦОВ; место жительства - БРЯНСК; родился - 8.12.87.  

		SELECT CONCAT(SUBSTR(Name, 1, 1), '.', UPPER(Surname), '; ', 'место жительства - ', UPPER(City), '; ', 'родился - ', DATE_FORMAT(Birthday, '%d.%m.%Y'))
		FROM Student; 
	Задание № 6:  Составьте запрос для таблицы STUDENT таким образом, чтобы выходная таблица содержала всего один столбец в следующем виде: Борис Кузнецов родился в 1987 году, но только для студентов 1, 2 и 4 курсов и таким образом, чтобы фамилии и имена были выведены прописными буквами. 

		SELECT CONCAT_WS(' ', UPPER(Name), UPPER(Surname), 'родился в', DATE_FORMAT(Birthday, '%Y'), 'году.')
		FROM Student
		WHERE Kurs IN (1, 2, 4);

Глава № 2.4: #4
	Задание № 8: Напишите запрос, выдающий средний балл для каждого студента.  
		SELECT Student_ID, AVG(Mark)
	FROM Exam_Marks
	GROUP BY Student_ID;
	
	Задание № 21: Для каждого дня сдачи экзаменов напишите запрос, выводящий среднее значение всех экзаменационных оценок. 
		
		SELECT Exam_Date, AVG(Mark)
		FROM Exam_Marks
		GROUP BY Exam_Date;
	
	Задание № 14: Для каждого студента напишите запрос, выводящий среднее значение оценок, полученных им на всех экзаменах. 

Глава № 2.7: #5
	Задание № 3: Напишите запрос, выполняющий вывод списка предметов обучения в порядке а) убывания семестров и б) возрастания количества отводимых на предмет часов. Поле семестра в выходных данных должно быть первым, за ним должны следовать имя предмета обучения и идентификатор предмета. 

	а) 
		SELECT Semester, Subj_Name, Subj_ID
		FROM Subject
		ORDER BY Semester DESC; 
	б)
		SELECT Semester, Subj_Name, Subj_ID, `Hour` 
		FROM Subject
		ORDER BY `Hour` ;

	Задание № 4: Напишите запрос, который для каждой даты сдачи экзаменов выполняет вывод суммы баллов всех студентов и представляет результаты в порядке убывания этих сумм. 

		SELECT Exam_Date, SUM(Mark)
		FROM Exam_Marks
		GROUP BY Exam_Date
		ORDER BY SUM(Mark) DESC;
 
Глава № 2.8: #6
	Задание № 1: Напишите запрос, выводящий список студентов, получающих максимальную стипендию, отсортировав его в алфавитном порядке по фамилиям.  

		SELECT Surname, Name, Stipend 
		FROM Student
		HAVING Stipend =
			(SELECT MAX(Stipend)
			FROM Student)
		ORDER BY Surname; 
	Задание № 4: Напишите запрос, выводящий список предметов, на изучение которых отведено максимальное количество часов. 

		SELECT Subj_Name, `Hour`
		FROM Subject
		HAVING `Hour` = 
			(SELECT MAX(`Hour`)
			FROM Subject);

Глава № 2.9: #7 	Задание № 10: Напишите запрос для получения списка неуспевающих студен- тов (получивших хотя бы одну неудовлетворительную оценку), с последующей сортировкой по идентификаторам университетов и курсам. 
 		SELECT *
		FROM Student ST
		WHERE 2 = 
			(SELECT MIN(Mark)
			FROM Exam_Marks EM
			WHERE ST.Student_ID = EM.Student_ID);
		ORDER BY Univ_ID, Kurs;

	Задание № 6: Напишите запрос для получения списка студентов, получающих минимальную стипендию в своем университете, с последующей сортировкой по значениям идентификатора университета и стипендии. 

		SELECT *
		FROM Student ST
		WHERE Stipend = 
			(SELECT MIN(Stipend)
			FROM Student
			WHERE Univ_ID = ST.Univ_ID)
		ORDER BY Univ_ID, Stipend;

Глава № 2.10: #8 Задание № 5: Напишите команду SELECT, использующую связанные подзапросы и выполняющую вывод имен и идентификаторов студентов, у которых стипендия совпадает с максимальным значением стипендии для города, в котором живет студент.

SELECT Name, Student_ID, Stipend 
FROM Student St1
HAVING Stipend = 
	(SELECT MAX(Stipend)
	FROM Student St2
	WHERE (St1.City = St2.City))

Задание №2: 
SELECT Name
FROM Student St, Exam_Marks Em
WHERE Mark > 
	(SELECT AVG(Mark) 
	FROM Exam_Marks em2) 
AND St.Student_ID = Em.Student_ID AND Subj_ID = 101;

Глава № 2.11: #9
Задание № 6: Напишите запрос для получения списка городов проживания студентов, в которых нет ни одного университета.

SELECT City
FROM Student A
WHERE NOT EXISTS
	(SELECT City
	FROM University B
	WHERE A.City = B.City)

Задание № 17: Напишите запрос, выполняющий вывод имен и фамилий студентов, не получивших ни одной отличной оценки.

SELECT Name, Surname, Student_ID 
FROM Student A
WHERE NOT EXISTS
	(SELECT Mark
	FROM Exam_Marks B
	WHERE A.Student_ID = B.Student_ID AND Mark = 5)

Глава № 2.12: #10
Задание № 3: Напишите запрос, выполняющий выборку значений идентификаторов студентов, имеющих такие же оценки, что и студент с идентификатором 12. 

SELECT DISTINCT Student_ID
FROM  Exam_Marks EM
WHERE Mark = ANY
	(SELECT Mark
	FROM Exam_Marks
	WHERE EM.Student_ID = 12)

Задание № 9: Напишите запрос, выполняющий вывод списка фамилий студентов, имеющих только отличные оценки и проживающих в городе, не совпадающем с городом их университета. 

SELECT  DISTINCT Surname
FROM  Student S
WHERE City <> 
	(SELECT City
	FROM University U
	WHERE S.Univ_ID = U.Univ_ID)
AND 5 = ALL
	(SELECT Mark
	FROM Exam_Marks EM
	WHERE S.Student_ID = EM.Student_ID)

Глава № 2.14: #11
Задание № 1: Напишите запрос, выбирающий данные о названиях университетов, рейтинг которых равен или превосходит рейтинг ВГУ.

SELECT Univ_Name
FROM University U
WHERE 1 >
	(SELECT COUNT(*)
	FROM University U2
	WHERE U2.Rating >= U.Rating AND Univ_Name = 'ВГУ')

Задание № 2: Напишите запрос с использованием ANY или ALL, выполняющий выборку данных о студентах, у которых в городе их постоянного местожительства нет университета.  
SELECT Surname
FROM Student S
WHERE City <> ALL 
	(SELECT City
	FROM University U
	WHERE S.Univ_ID = U.Univ_ID)

Глава 2.15: #12
	Задание № 1: Напишите запрос для получения списка предметов вместе с фамилиями студентов, изучающих их на соответствующем курсе.  
SELECT Subject.Subj_Name, Student.Surname, Student.Kurs, Subject.Semester
FROM Student JOIN Subject
ON Student.Kurs * 2 - 1 = Subject.Semester OR Student.Kurs * 2 = Subject.Semester;

	Задание № 2: Напишите запрос, выполняющий вывод имен и фамилий студентов, имеющих весь набор положительных (тройки, четверки и пятерки) оценок. 

SELECT Student.Surname, Student.Name, Exam_Marks.Mark
FROM Student JOIN Exam_Marks
ON Exam_Marks.Mark > 2 AND Student.Student_ID = Exam_Marks.Student_ID ;

Глава 2.15.1: #13
	Задание № 12: Напишите запрос для получения списка предметов вместе с фамилиями студентов, получивших по данному предмету максимальную оценку.  
SELECT Student.Surname, Subject.Subj_Name, Exam_Marks.Mark
FROM Student JOIN Exam_Marks
ON Exam_Marks.Mark = 5 AND Student.Student_ID = Exam_Marks.Student_ID
JOIN Subject
ON Exam_Marks.Subj_ID = Subject.Subj_ID;

	Задание № 20: Напишите запрос, выполняющий вывод данных о предметах обучения, которые преподает Колесников.  
Вариант 1):
SELECT Subject.Subj_Name, Lecturer.Surname 
FROM Subject S JOIN Subj_Lect SL
ON S.Subj_ID = SL.Subj_ID
JOIN Lecturer L 
ON SL.Lecturer_ID = L.Lecturer_ID AND L.Surname = 'Колесников';

Вариант 2):
SELECT * 
FROM Subject S, Subj_Lect SL, Lecturer L
WHERE S.Subj_ID=SL.Subj_ID
AND SL.Lecturer_ID=L.Lecturer_ID AND L.Surname='Колесников';

Глава 2.15.2: #14
	Задание № 4: Напишите запрос на выдачу списка всех студентов. Для студен- тов, сдававших экзамены, укажите названия соответствующих предметов обучения. 

SELECT Surname, Subj_Name 
FROM Student S LEFT OUTER JOIN Exam_Marks EM
ON S.Student_ID = EM.Student_ID 
LEFT OUTER JOIN Subject S2 
ON S2.Subj_ID = EM.Subj_ID;

	Задание № 8: Напишите запрос для получения списка всех студентов вместе с названиями университетов, в которых они учатся.

SELECT Surname, Univ_Name
FROM Student S LEFT OUTER JOIN University U
ON S.Univ_ID = U.Univ_ID;

Глава 2.15.3: #15
	Задание № 2: Напишите запрос, выполняющий вывод списка всех пар названий университетов, расположенных в одном городе, не включая в список комбинации названий университетов самих с собой и пары названий университетов, отличающиеся порядком следования. 

SELECT A.Univ_Name, B.Univ_Name
FROM University A, University B
WHERE A.City = B.City AND A.Univ_Name < B.Univ_Name;

	Задание № 5: Напишите запрос, выполняющий выборку всех пар идентификаторов преподавателей, ведущих один и тот же предмет обучения. 
 SELECT A.Lecturer_ID, B.Lecturer_ID
FROM Subj_Lect A, Subj_Lect B
WHERE A.Subj_ID = B.Subj_ID AND A.Lecturer_ID < B.Lecturer_ID;


Глава 2.16.2: #16
	Задание № 4: Выведите объединенный список студентов и преподавателей ВГУ с соответствующими комментариями ‘студент’ или ‘преподаватель’. 

SELECT 'Студент', Surname
FROM Student A, University B
WHERE A.Univ_ID = B.Univ_ID AND B.Univ_Name = 'ВГУ'
UNION ALL 
SELECT 'Преподаватель', Surname
FROM Lecturer C, University D
WHERE C.Univ_ID = D.Univ_ID AND D.Univ_Name = 'ВГУ';

	Задание № 8: Напишите запрос для получения полного списка университетов вместе с фамилиями студентов, которые в них учатся. Для университетов, не имеющих студентов, поместите в список фразу ‘Студентов нет’. 
  SELECT Univ_Name, Surname
FROM University U JOIN Student S 
ON U.Univ_ID = S.Univ_ID 
UNION ALL 
SELECT Univ_Name, 'Студентов нет'
FROM University U2
WHERE NOT EXISTS (
	SELECT Univ_ID
	FROM Student S2
	WHERE Univ_ID = U2.Univ_ID
);

Глава 3.1: #17
	Задание № 1: Напишите команду, которая вводит в таблицу SUBJECT строку для нового предмета обучения со следующими значениями полей: SEMESTER = 4; SUBJ_NAME = ‘Алгебра’; HOUR = 72; SUBJ_ID = 201.  
 INSERT INTO Subject 
	VALUES ('201', 'Алгебра', '72', '4');

	Задание № 4: Напишите команду, которая увеличивает на 5 значение рейтинга всех университетов, расположенных в Санкт-Петербурге. 

UPDATE University 
	SET Rating = Rating + 5
	WHERE City = 'Санкт-Петербург';
 
Глава 3.2: #18
	Задание № 2: Напишите команду, удаляющую из таблицы SUBJECT1 сведения о предметах обучения, по которым студентами не получено ни одной оценки. 

DELETE 
 FROM Subject1
 WHERE 0 = 
 	(SELECT COUNT(Mark)
 	FROM Exam_Marks
 	WHERE Subject1.Subj_ID = Exam_Marks.Subj_ID);

Задание № 3: Напишите запрос, увеличивающий размер стипендии на 20% всем студентам, у которых общая сумма баллов превышает значение 50. 

UPDATE Student
	SET Stipend = Stipend * 1.20
	WHERE 50 <= 
		(SELECT SUM(Mark)
		FROM Exam_Marks
		WHERE Student.Student_ID = Exam_Marks.Student_ID);

