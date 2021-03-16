CREATE DATABASE IF NOT EXISTS book1;

USE book1;

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
	lampu_lalin VARCHAR(6) PRIMARY KEY
);

DELETE FROM sheet2;

ALTER TABLE sheet2
	DROP PRIMARY KEY;


ALTER  TABLE sheet2
	ADD PRIMARY KEY(lampu_lalin);

INSERT INTO sheet2 VALUES
	('MERAH'),
	('KUNING'),
	('HIJAU');

SELECT lampu_lalin AS lampu_lalin
FROM sheet2
GROUP BY lampu_lalin;

 SELECT lampu_lalin as 'Lampu lalin',
	IF(lampu_lalin='MERAH', 
		'Berhenti',
		IF(lampu_lalin='KUNING',
			'Berhati-hati',
			'Jalan'
			)
		)
	 AS STATUS_LAMPU_LALIN
FROM sheet2;

			/* Record Ke 3 */

CREATE TABLE IF NOT EXISTS warga(
	nama VARCHAR(6),
	jenis_kelamin VARCHAR(6),
	status VARCHAR(7),
	PRIMARY KEY(nama,jenis_kelamin,status)
);
DELETE FROM warga;


/*ALTER  TABLE warga
	ADD PRIMARY KEY(nama,jenis_kelamin,status); */


INSERT INTO warga VALUES
	('Amin','Pria','sendiri'),
	('Rahman','Pria','kawin'),
	('Luki','Pria','Cerai'),
	('Dea','Wanita','sendiri'),
	('Dea','Pria','Kawin'),
	('Dea','Pria','Cerai'),
	('Yani','Wanita','kawin'),
	('Endah','Wanita','Cerai');
	
DROP VIEW vw_seluruh_warga;

CREATE VIEW vw_seluruh_warga AS
SELECT *
FROM warga;
SELECT 	nama,
		jenis_kelamin,
		status,
		IF(jenis_kelamin='Pria',
			IF(status='sendiri',
				'Perjaka',
				IF(status='Kawin',
					'Menikah',
					'Duda'
					)
				),
			IF(status='sendiri',
				'Perawan',
				IF(status='Kawin',
					'Menikah',
					'Janda'))
		)
			AS keterangan_IF,

		CASE WHEN jenis_kelamin='Pria'
			THEN 
			CASE WHEN status= 'sendiri'
				THEN  'Perjaka'
				ELSE
					CASE WHEN status='Kawin'
					THEN 'Menikah'
					ELSE 
					'Duda'
					END
			END
			ELSE

			CASE WHEN status= 'sendiri'
				THEN 'Perawan'
				ELSE
					CASE WHEN status='Kawin' THEN  'Menikah'
					ELSE 'Janda'
					END
			END
		END
		AS keterangan_Case,


		CASE jenis_kelamin
			WHEN 'Pria' THEN
				CASE status
					WHEN 'sendiri' THEN 'Perjaka'
					WHEN 'Kawin' THEN 'Menikah'
					ELSE 'Duda'
					END
				
			ELSE
				CASE status
					WHEN 'sendiri' THEN 'Perawan'
					WHEN 'Kawin' THEN 'Menikah'
					ELSE 'Janda'
					END
				END AS ket_Case,

			IF(jenis_kelamin='Pria',
				CASE status
					WHEN 'sendiri' THEN 'Perjaka'
					WHEN 'Kawin' THEN 'Janda'
					ELSE 'Duda'
				END,
				CASE status
					WHEN 'sendiri' THEN 'Perawan'
					WHEN 'Kawin' THEN 'Menikah'
					ELSE 'Janda'
				END
				) AS Keterangan_IF_CASE


FROM vw_seluruh_warga;

/* nilai */

CREATE TABLE IF NOT EXISTS nilai (
	nama VARCHAR(15),
	teori TINYINT,
	prakter TINYINT,
	PRIMARY KEY (nama, teori, prakter)
);

DELETE FROM nilai;


INSERT INTO nilai VALUES
 ("M.Septiawan", "100", "100"),
 ("Damayanti", "70", "90"),
 ("Dzakiy", "85", "79"),
 ("Dzaka", "68", "75"),
 ("Chacha", "43", "68");

 DROP VIEW list_nilai;

 CREATE VIEW list_nilai as
 SELECT *
 FROM nilai;

SELECT nama, 

		teori,
		teori*30/100 as 'Nilai_teori_30%',

	 	prakter,
	 	prakter*70/100 as 'Nilai_Prakter_70%',

	 	teori*30/100 + prakter*70/100 as Total,

	 	CASE
	 		WHEN teori*30/100 + prakter*70/100 > 90 
	 			THEN 'A'
	 		WHEN teori*30/100 + prakter*70/100 > 80
	 			THEN 'B'
	 		WHEN teori*30/100 + prakter*70/100 > 70
	 			THEN 'C'
	 		WHEN teori*30/100 + prakter*70/100 > 60
	 			THEN 'D'
	 		ELSE 'E'
	 	END as Grade,

	 	CASE
	 		WHEN teori*30/100 + prakter*70/100 > 80
	 			THEN 'K'
	 		ELSE 'BK'
	 	END as Kompetensi,

	 	CASE
	 		WHEN teori*30/100 + prakter*70/100 > 90
	 			THEN 'Memuaskan'
	 		WHEN teori*30/100 + prakter*70/100 > 80
	 			THEN 'Baik'
	 		WHEN teori*30/100 + prakter*70/100 > 70
	 			THEN 'Cukup'
	 		WHEN teori*30/100 + prakter*70/100 > 60
	 			THEN 'Kurang'
	 		ELSE 'Kurang Kompeten'
	 		END AS Keterangan
FROM list_nilai;




 -- CREATE VIEW table_nilai;






/* SELECT nama
FROM vw_seluruh_warga; */
-- harus drop view untuk select nama saja dari view. jika tidak drop view terlebih dahulu maka akan error


