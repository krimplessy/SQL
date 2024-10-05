CREATE TABLE Registration_of_incident_reports
	(Registration_number_of_message INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	 Date_of_registration DATE NOT NULL,
	 Incident_type VARCHAR(60) NOT NULL);

ALTER TABLE Registration_of_incident_reports AUTO_INCREMENT = 100000;

CREATE TABLE Incident_decision
	(Case_number INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	 Registration_number_of_message INTEGER NOT NULL UNIQUE,
	 Proceeding_denied VARCHAR(10) NOT NULL,
	 Proceeding_satisfied VARCHAR(10) NOT NULL,
	 Sent_by_territory VARCHAR(10) NOT NULL);
	 
ALTER TABLE Incident_decision AUTO_INCREMENT = 100000;

CREATE TABLE Participant_Information
	(Case_number INTEGER NOT NULL,
	 Registration_number_of_participant INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
	 Full_name VARCHAR(60) NOT NULL,
	 Address VARCHAR(60) NOT NULL,
	 Number_of_convictions INTEGER NOT NULL,
	 Relation_to_the_incident VARCHAR(60) NOT NULL);
	 
ALTER TABLE Participant_Information AUTO_INCREMENT = 100000;

ALTER TABLE Incident_decision 
	ADD CONSTRAINT Relation_between_report_and_case
	FOREIGN KEY (Registration_number_of_message)
		REFERENCES Registration_of_incident_reports (Registration_number_of_message);
	
ALTER TABLE Participant_Information 
	ADD CONSTRAINT Case_number
	FOREIGN KEY (Case_number)
		REFERENCES Incident_decision (Case_number);
	
ALTER TABLE Incident_decision 
	MODIFY Proceeding_denied VARCHAR(10) NOT NULL DEFAULT "Нет" CHECK (Proceeding_denied = "Да" OR Proceeding_denied = "Нет");
	
ALTER TABLE Incident_decision 
	MODIFY Proceeding_satisfied VARCHAR(10) NOT NULL DEFAULT "Нет" CHECK (Proceeding_satisfied = "Да" OR Proceeding_satisfied = "Нет");
	
ALTER TABLE Incident_decision 
	MODIFY Sent_by_territory VARCHAR(10) NOT NULL DEFAULT "Нет" CHECK (Sent_by_territory = "Да" OR Sent_by_territory = "Нет");

#Запрос № 1: Вывести тех на кого заведено уголовное дело и у кого судимостей > 2
/*SELECT Full_name, Number_of_convictions, Relation_to_the_incident
FROM Incident_decision id, Participant_Information pi2 
WHERE id.Proceeding_satisfied = 'Да' AND id.Case_number = pi2.Case_number AND pi2.Number_of_convictions > 2;*/

#Запрос № 2: Вывести тех, кто причастен к одному и тому же делу, если участников больше 1
/*SELECT Full_name
FROM Participant_Information A
WHERE EXISTS 
	(SELECT *
	 FROM Participant_Information B
	 WHERE A.Case_number = B.Case_number
	 AND A.Registration_number_of_participant <> B.Registration_number_of_participant);*/

#Запрос № 3: Вывести тип и дату происшествия виновных участников с отклоненным на возбуждение делом
/*SELECT Incident_type, Date_of_registration, Full_name
FROM Registration_of_incident_reports A, Participant_Information B, Incident_decision C
WHERE A.Registration_number_of_message = C.Registration_number_of_message 
AND B.Case_number = C.Case_number AND C.Proceeding_denied = 'Да'
AND B.Relation_to_the_incident = 'Виновник';*/

#Запрос № 4: Вывести информацию о том, на кого возбуждено уголовное дело, на кого нет, у кого дело переслано
/*SELECT 'Возбуждено уголовное дело', Full_name, Address
	FROM Participant_Information A, Incident_decision B
	WHERE A.Case_number = B.Case_number AND B.Proceeding_satisfied = 'Да'
UNION
SELECT 'Отклонено в возбуждении уголовного дела', Full_name, Address
	FROM Participant_Information A, Incident_decision B
	WHERE A.Case_number = B.Case_number AND B.Proceeding_denied = 'Да'
UNION
SELECT 'Переслано в другое территориальное отделение', Full_name, Address
	FROM Participant_Information A, Incident_decision B
	WHERE A.Case_number = B.Case_number AND B.Sent_by_territory = 'Да';*/

#Запрос № 5: Вывести информацию о происшествиях, участниками, которых являются Пострадавший или Свидетель
/*SELECT Incident_type, Date_of_registration, Full_name, Relation_to_the_incident
FROM Registration_of_incident_reports A JOIN Incident_decision B 
ON A.Registration_number_of_message = B.Registration_number_of_message 
JOIN Participant_Information C 
ON B.Case_number = C.Case_number
WHERE C.Relation_to_the_incident = 'Пострадавший' OR C.Relation_to_the_incident = 'Свидетель';*/

#Запрос № 6: Добавьте новое сообщение о происшествии, затем поменяйте одно из значений, затем удалите данные об этом сообщении
/*INSERT INTO Registration_of_incident_reports
	VALUES ('500', '10.10.2022', 'Наезд на пешехода');*/

/*UPDATE Registration_of_incident_reports 
	SET Date_of_registration = '2022.11.28'
	WHERE Registration_number_of_message = '500';*/

/*DELETE FROM Registration_of_incident_reports 
WHERE Registration_number_of_message = '500';*/













