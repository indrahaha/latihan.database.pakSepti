DROP DATABASE pns;

CREATE DATABASE pns;
USE pns;



CREATE TABLE IF NOT EXISTS pegawai (
	nip VARCHAR(18) PRIMARY KEY,
	nama_pegawai VARCHAR(12)
);

/* pegawai */

DELETE FROM pegawai;


DELIMITER ;;
CREATE PROCEDURE sp_ins_pegawai (
	m_nip_pgw	VARCHAR(18),
	m_nama_pgw	VARCHAR(18)
)
BEGIN 
	INSERT INTO pegawai(nip, nama_pegawai) VALUES
	(m_nip_pgw, m_nama_pgw);

	SELECT nip, nama_pegawai
	FROM pegawai;
	END;;
DELIMITER ;

CALL sp_ins_pegawai('197209172005011002','M. Septiawan');
CALL sp_ins_pegawai('198201312010052001','Damayanti');
CALL sp_ins_pegawai('200901202015071004','M. N. Dzakiy');
CALL sp_ins_pegawai('201507142019031002','M. N. Dzaka');
CALL sp_ins_pegawai('201411142020102003','N. Tsalsa N.');



ALTER TABLE pegawai
	ADD COLUMN agama VARCHAR(9);



DELIMITER ;;
CREATE PROCEDURE sp_apd_agama(
	m_agama	VARCHAR(9),
	m_nip_agama VARCHAR(18)
	
)
BEGIN 
	UPDATE pegawai 
	SET agama = m_agama 
	WHERE nip = m_nip_agama;

	END;;
DELIMITER ;

CALL sp_apd_agama('islam','197209172005011002');
CALL sp_apd_agama('islam','198201312010052001');
CALL sp_apd_agama('islam','200901202015071004');
CALL sp_apd_agama('islam','201507142019031002');
CALL sp_apd_agama('islam','201411142020102003');



 CREATE TABLE agama(
		kode_agam VARCHAR(1) PRIMARY KEY,
		nama_agama VARCHAR(11)
);


DELIMITER ;;
CREATE PROCEDURE sp_ins_agamaku(
		m_kode_agama VARCHAR(1),
		m_nama_agama VARCHAR(11)
)

BEGIN 
		INSERT INTO agama VALUES
		(m_kode_agama, m_nama_agama);

		SELECT m_kode_agama, m_nama_agama
		FROM pegawai;
END;;
DELIMITER ;

/*
CALL sp_ins_agamaku('1', 'Islam');
CALL sp_ins_agamaku('2', 'Katholik');
CALL sp_ins_agamaku('3', 'Protestan');
CALL sp_ins_agamaku('4', 'Hindu');
CALL sp_ins_agamaku('5', 'Budha');
CALL sp_ins_agamaku('6', 'Kepercayaan');
*/

DELIMITER ;;
 CREATE PROCEDURE sp_ins_agamalist (
 		m_jml_agama TINYINT
 	)
 BEGIN 
 	DECLARE ulang TINYINT;
 	SET ulang = 1;
 	WHILE ulang <= m_jml_agama DO
 		INSERT INTO agama VALUES (
 			CONVERT(ulang, CHAR),
 			elt(ulang, 'Islam', 'Katholik', 'Protestan', 'Hindu', 'Budha', 'Kepercayaan')
 			);
 		SET ulang = ulang + 1;
 		END WHILE;
 		SELECT *
 		FROM agama;
 	END;;

DELIMITER ;

CALL sp_ins_agamalist(6);

ALTER TABLE pegawai
	DROP agama;

ALTER TABLE pegawai
	ADD COLUMN kode_agama VARCHAR(1);

ALTER TABLE pegawai
	ADD CONSTRAINT fk_pegawai_2_agama FOREIGN KEY (kode_agama)
		REFERENCES agama(kode_agam);


DELIMITER ;;
CREATE PROCEDURE sp_upd_agama2(
	m_kode_agama	VARCHAR(1),
	m_nip_agama VARCHAR(18)
	
)
BEGIN 
	UPDATE pegawai 
	SET kode_agama = m_kode_agama 
	WHERE nip = m_nip_agama;

	END;;
DELIMITER ;
CALL sp_upd_agama2('1','197209172005011002');
CALL sp_upd_agama2('1','198201312010052001');
CALL sp_upd_agama2('1','200901202015071004');
CALL sp_upd_agama2('1','201507142019031002');
CALL sp_upd_agama2('1','201411142020102003');


CREATE VIEW vw_pgw AS 
SELECT nip,
		nama_pegawai,
		nama_agama
FROM pegawai, agama
WHERE pegawai.kode_agama = agama.kode_agam;

 /* and
	agama.nama_agama = 'Islam';
*/



DELIMITER ;;
CREATE PROCEDURE sp_upd_agama3(
	m_kode_agama	VARCHAR(1),
	m_nip_agama VARCHAR(18)
	
)
BEGIN 


	UPDATE pegawai 
	SET kode_agama = m_kode_agama 
	WHERE nip = m_nip_agama;
	

	END;;
DELIMITER ;

CALL sp_upd_agama3('1','197209172005011002');
CALL sp_upd_agama3('2','198201312010052001');
CALL sp_upd_agama3('3','200901202015071004');
CALL sp_upd_agama3('4','201507142019031002');
CALL sp_upd_agama3('5','201411142020102003');

CREATE VIEW vw_pgw_3 AS 
SELECT nip,
		nama_pegawai,
		nama_agama
FROM pegawai, agama
WHERE pegawai.kode_agama = agama.kode_agam;

DELIMITER ;;
CREATE PROCEDURE sp_ins_pegawai_baru(
		m_nip_pgw	VARCHAR(18),
		m_nama_pgw VARCHAR(12),
		m_kode_agama VARCHAR(1)
)

	BEGIN 
	INSERT INTO pegawai VALUES
	(m_nip_pgw, m_nama_pgw, m_kode_agama);

	SELECT * 
	FROM agama;
END;;
DELIMITER ;

CALL sp_ins_pegawai_baru('197909202005011001', 'Helena Simorangkir', '2');
CALL sp_ins_pegawai_baru('198901312010052001', 'Johanes Albertus', '3');
CALL sp_ins_pegawai_baru('198901202015071001', 'Weni', '4');
CALL sp_ins_pegawai_baru('197007142019031001', 'I Made', '5');
CALL sp_ins_pegawai_baru('197011142020102001', 'Jacky', '6');


CREATE VIEW vw_info_pgw AS
	SELECT  nama_pegawai,
			nip,
			DATE_FORMAT(LEFT(nip,8), "%W, %d %M %Y") AS Tanggal_Lahir,
			DATE_FORMAT(CONCAT(MID(nip,9,6),'01'), "%M , %Y") AS Tanggal_Pengangkatan_Pns,
			IF(MID(nip,15,1)='1','Pria','Wanita') AS Jenis_Kelamin,
			RIGHT(nip,3) AS no_urut,
			nama_agama
	FROM pegawai, agama
	WHERE pegawai.kode_agama = agama.kode_agam;

CREATE VIEW vw_info_umur AS
	SELECT nama_pegawai,
			nip,
			DATE_FORMAT(LEFT(nip,8), "%W, %d %M %Y") AS Tanggal_Lahir,
			YEAR(CURDATE()) - YEAR(LEFT(nip,8)) AS usia,
			TIMESTAMPDIFF(YEAR,LEFT(nip,8), CURDATE())  AS usia2,
			DATE_FORMAT(CONCAT(MID(nip,9,6),'01'), "%M , %Y") AS Tanggal_Pengangkatan_Pns,
			IF(MID(nip,15,1)='1','Pria','Wanita') AS Jenis_Kelamin,
			RIGHT(nip,3) AS no_urut,
			nama_agama
	FROM pegawai, agama
	WHERE pegawai.kode_agama = agama.kode_agam;

-- CREATE VIEW vw_tgl_lahir AS 
-- SELECT nip,
-- 		nama_pegawai,
-- 	DATE_FORMAT(LEFT(nip,8), "%W, %D %M %Y" )
-- 		 AS Tanggal_Lahir,
-- 		DATE_FORMAT(CONCAT(MID(nip,9,6),'01'), "%M , %Y") 
-- 		AS Tanggal_Pengangkatan_Pns
-- FROM pegawai;

-- CREATE VIEW vw_jenis_kelamin AS
-- 	SELECT nip,
-- 			nama_pegawai,
-- 			Tanggal_Lahir,
-- 			Tanggal_Pengangkatan_Pns,
-- 			IF (MID(nip,15,1)='1','Pria','Wanita') AS Jenis_Kelamin
-- 	FROM vw_tgl_lahir;

-- CREATE VIEW vw_no_urut AS
-- 	SELECT nip,
-- 			nama_pegawai,0
-- 			Tanggal_Lahir,
-- 			Tanggal_Pengangkatan_Pns,
-- 			Jenis_Kelamin,
-- 			RIGHT(nip,3) AS no_urut
-- 	FROM vw_jenis_kelamin;

-- CREATE PROCEDURE sp_info_tgl_lahir (
-- 		m_nip_pgw	VARCHAR(18),
-- 		m_nama_pgw VARCHAR(12),
-- 		m_kode_agama VARCHAR(1)
-- )


-- CREATE PROCEDURE sp_lihat_agama(
-- 		l_kode_agama INT
-- )
-- 		BEGIN
-- 		DECLARE i INT DEFAULT 1;
-- 		DECLARE listAgama VARCHAR(100) DEFAULT '<a>Islam</a><a>Katholik</a><a>Protestan</a><a>Hindu</a><a>Budha</a><a>Kepercayaan</a>';
		
-- 			WHILE i <= l_kode_agama DO
-- 		 		SELECT i, Extractvalue(listAgama, '//[$i]') as Agama;
-- 		 		SET i = i+1;
-- 		 		END WHILE;
-- END;;

-- DELIMITER ;

-- CALL sp_lihat_agama;

		
/*
CREATE TABLE agama_pgw(
		kode INT NOT NULL AUTO_INCREMENT,
		agama VARCHAR(12),
		PRIMARY KEY (kode)
);
	


DELIMITER ;;
CREATE PROCEDURE sp_agama_pgw(
	list_kode INT,
	list_agama VARCHAR(12)
)

BEGIN
		INSERT INTO agama_pgw VALUES (list_kode, list_agama);
	END;;

DELIMITER ;

CALL sp_agama_pgw("1", "islam");
CALL sp_agama_pgw("2", "Khatolik");
CALL sp_agama_pgw("3", "Protestan");
CALL sp_agama_pgw("4", "Hindu");
CALL sp_agama_pgw("5", "Budha");
CALL sp_agama_pgw("6", "Kepercayaan");

ALTER TABLE pegawai
		ADD list_kode INT;

DELIMITER ;;
CREATE PROCEDURE sp_pegawai_agama(
		nip_p VARCHAR(18),
		kode_p INT
)
		
BEGIN 
		UPDATE pegawai SET list_kode = kode_p
		WHERE nip = nip_p;

		SELECT pegawai.nip, pegawai.nama_pegawai, agama_pgw.agama
		FROM pegawai.list_kode = agama_pgw.agama;
END;;
DELIMITER ;

CALL sp_pegawai_agama('197209172005011002', '1');
CALL sp_pegawai_agama('198201312010052001', '2');	
CALL sp_pegawai_agama('200901202015071004', '3');	
CALL sp_pegawai_agama('201507142019031002', '4');			
*/





-- INSERT INTO pegawai(agama) VALUES
-- 	("Islam"),
-- 	("Khatolik"),
-- 	("Protestan"),
-- 	("Hindu"),
-- 	("Budha"),
-- 	("Kepercayaan");


-- INSERT INTO pegawai(nip, nama_pegawai) VALUES
-- ('197209172005011002','M. Septiawan'),
-- ('198201312010052001','Damayanti'),
-- ('200901202015071004','M. N. Dzakiy'),
-- ('201507142019031002','M. N. Dzaka'),
-- ('201411142020102003','N. Tsalsa N.');


/*
DROP VIEW vw_tgl_lahir;

CREATE VIEW vw_tgl_lahir AS 
SELECT nip,
		nama_pegawai,
	DATE_FORMAT(LEFT(nip,8), "%W, %D %M %Y" )
		 AS Tanggal_Lahir,
		 CONCAT(
		 	MID(nip,7,2),-
		 	MID(nip,5,2),-
		 	LEFT(nip,4))
		 AS	TGL_LAHIR,

		DATE_FORMAT(CONCAT(MID(nip,9,6),'01'), "%M , %Y") 
		AS Tanggal_Pengangkatan_Pns
FROM pegawai;
*/

/* beda view */
/*
DROP VIEW vw_tgl_jk;

CREATE VIEW vw_tgl_jk AS
SELECT nip,
		nama_pegawai,
		MID(nip,7,2) AS tgl_lhr,
		MID(nip,5,2) AS bln_lhr,
		LEFT(nip,4) AS thn_lhr,
		MID(nip,13,2) AS bln_pengangkatan,
		MID(nip,9,4) AS thn_pengangkatan,
		IF (MID(nip,15,1)='1','Pria','Wanita') AS Jenis_Kelamin,
		RIGHT(nip,3) AS no_urut

FROM pegawai;

DROP VIEW vw_tgl_concat;

CREATE VIEW vw_tgl_concat AS 
SELECT	nip,
		nama_pegawai,
		tgl_lhr,
		bln_lhr,
		DATE_FORMAT(CONCAT(thn_lhr,bln_lhr,tgl_lhr), '%W, %d %M %Y') as tanggal_Lahir,
		DATE_FORMAT(LEFT(nip,8), '%W, %d %M %Y') AS tanggal_lahir2,
		bln_pengangkatan,
		thn_pengangkatan,
		Jenis_Kelamin,
		no_urut
FROM vw_tgl_jk;

DROP VIEW vw_data;

CREATE VIEW vw_data AS 
SELECT nip,
		nama_pegawai,
		tgl_lhr,
		bln_lhr,
		tanggal_Lahir,
		tanggal_lahir2,
		DATE_FORMAT(CONCAT(SUBSTRING(nip,9,4),"-",SUBSTRING(nip,13,2),"-",SUBSTRING(nip,7,2)),"%M, %Y") as tanggal_pengangkatan,
		Jenis_Kelamin,
		no_urut
FROM vw_tgl_concat;
*/
-- delimiter

/*
DROP PROCEDURE sp_info_pgw_jnskel;

DELIMITER ;;
CREATE PROCEDURE sp_info_pgw_jnskel(
	m_jns_kel VARCHAR(6)
)
BEGIN
	SELECT nama_pegawai,
		   Jenis_Kelamin
	FROM vw_data
	WHERE Jenis_Kelamin = m_jns_kel;
END;;
DELIMITER ;

CALL sp_info_pgw_jnskel('Pria');
CALL sp_info_pgw_jnskel('Wanita');

*/