UPDATE Student
	SET Stipend = Stipend * 1.20
	WHERE 50 <= 
		(SELECT SUM(Mark)
		FROM Exam_Marks
		WHERE Student.Student_ID = Exam_Marks.Student_ID);