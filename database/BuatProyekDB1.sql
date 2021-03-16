CREATE DATABASE IF NOT EXISTS book2;

USE book2;

CREATE TABLE IF NOT EXISTS sheet1 (
	saklar_lampu	VARCHAR(3)
);

 DELETE FROM sheet1;

 ALTER TABLE sheet1
	DROP PRIMARY KEY;

ALTER  TABLE sheet1
	ADD PRIMARY KEY(saklar_lampu);

-- Memasukkan 2 record sekaligus
INSERT INTO sheet1 (saklar_lampu) VALUES
	('ON'),
	('OFF'); 

/*INSERT INTO sheet1 (saklar_lampu) VALUES
	('ON'),
	('OFF'); 
*/

/* debug untuk jumlah Record */
SELECT saklar_lampu as 'Nama Saklar Lampu'
	   /* Tidak Disarankan*/ ,
	   COUNT(saklar_lampu) as Status_Saklar_Lampu
FROM   sheet1
GROUP BY saklar_lampu
ORDER BY saklar_lampu ASC;

SELECT saklar_lampu AS 'SAKLAR LAMPU',
		IF(saklar_lampu='ON','Nyala','Mati') AS STATUS_LAMPU
FROM sheet1;

/* sheet 2 */

CREATE TABLE IF NOT EXISTS sheet2 (
	lampu_lalin VARCHAR(6)
);

INSERT INTO sheet2 VALUES
	('MERAH'),
	('KUNING'),
	('HIJAU');

SELECT lampu_lalin AS lampu_lalin
FROM sheet2
GROUP BY lampu_lalin;

SELECT lampu_lalin as 'Lampu lalin',
	IF(lampu_lalin='MERAH', 'Berhenti',
	IF(lampu_lalin='KUNING','Berhati-hati','Jalan'))
	 AS STATUS_LAMPU_LALIN
FROM sheet2;

	/*=IF(C9="Merah";"Berhenti";IF(C9="Kuning";"berhati-hati";"Jalan")) */