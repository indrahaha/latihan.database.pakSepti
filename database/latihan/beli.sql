DROP DATABASE beli;
CREATE DATABASE beli;
use beli;

CREATE TABLE pembeli(
	kd_beli VARCHAR(15)PRIMARY KEY,
	nm_beli VARCHAR(20),
	AlmtPembeli VARCHAR(35),
	kecPembeli VARCHAR(20),
	kdposPembeli VARCHAR(20),
	kotaPembeli VARCHAR(20),
	propPembeli VARCHAR(20)

);
CREATE TABLE barang(
	kode_barang VARCHAR(15)PRIMARY KEY,
	nm_barang VARCHAR(20),
	satuan_barang VARCHAR(20)
);
CREATE TABLE pegawai(
	no_pegawai VARCHAR(20)PRIMARY KEY,
	nm_pegawai VARCHAR(20),
	jab_pegawai VARCHAR(20),
	AlmtPegawai VARCHAR(35),
	kecPegawai VARCHAR(20),
	kdposPegawai VARCHAR(20),
	kotaPegawai VARCHAR(20),
	propPegawai VARCHAR(20)
);

CREATE TABLE pesan_detail(
	no_pesan VARCHAR(20),
	tgl_pesan VARCHAR(20),
	kode_barang VARCHAR(15),
	jml_barang VARCHAR(4),
	cttn_pesan VARCHAR(50),
	PRIMARY KEY(no_pesan),
	CONSTRAINT kode_barang FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang)
);

CREATE TABLE pesan_header(
	no_pesan VARCHAR(20),
	tgl_pesan DATE,
	kd_beli VARCHAR(15),
	no_pegawai VARCHAR(20),
	cttn_terimabrg VARCHAR(20),
	cttn_bayarbrg VARCHAR(20),
	cttn_kirimbon VARCHAR(20),
	PRIMARY KEY(no_pesan,tgl_pesan,kd_beli,no_pegawai),
	CONSTRAINT no_pesan FOREIGN KEY (no_pesan) REFERENCES pesan_detail(no_pesan),
	CONSTRAINT kd_beli FOREIGN KEY (kd_beli) REFERENCES pembeli(kd_beli),
	CONSTRAINT no_pegawai FOREIGN KEY (no_pegawai) REFERENCES pegawai(no_pegawai)
);

INSERT INTO pembeli VALUES
("1","Toko Permata Indah","jalan mawar no.42","","","","Yogyakarta"),
("2","Toko Permata Indah","jalan mawar no.42","","","","Yogyakarta"),
("3","Toko Permata Indah","jalan mawar no.42","","","","Yogyakarta"),
("4","Toko Buku Belajar Bersama","jalan cigantri No.112","Lengkong","","","Bandung"),
("5","Toko Buku Belajar Bersama","jalan cigantri No.112","Lengkong","","","Bandung");

INSERT INTO barang VALUES
("1","3",""),
("2","10",""),
("3","3",""),
("4","5",""),
("5","8","");

INSERT INTO pegawai VALUES
("1","Agung","Senior Sales","","","","",""),
("2","Agung","Senior Sales","","","","",""),
("3","Agung","Senior Sales","","","","",""),
("4","Alfi","Junior Sales","","","","",""),
("5","Alfi","Junior Sales","","","","","");

INSERT INTO pesan_detail VALUES
("1","21-08-2015","1","3","Barang diterima 31/08/2015, pembayaran 2 hari setelah penerima barang, mengirim fotocopy pembayaran"),
("2","21-08-2015","2","10","Barang diterima 31/08/2015, pembayaran 2 hari setelah penerima barang, mengirim fotocopy pembayaran"),
("3","21-08-2015","3","3","Barang diterima 31/08/2015, pembayaran 2 hari setelah penerima barang, mengirim fotocopy pembayaran"),
("4","21-08-2015","4","5","Barang diterima 31/08/2015, pembayaran setelah penerima barang, mengirim fotocopy pembayaran"),
("5","21-08-2015","5","8","Barang diterima 31/08/2015, pembayaran setelah penerima barang, mengirim fotocopy pembayaran");

-- INSERT INTO pesan_header VALUES
-- ("","21-08-2015","","","","",""),
-- ("","21-08-2015","","","","",""),
-- ("","21-08-2015","","","","",""),
-- ("","21-08-2015","","","","",""),
-- ("","21-08-2015","","","","","");


-- ("","Toko Permata Indah","jalan mawar no.42","","","","Yogyakarta"),
-- ("","Toko Permata Indah","jalan mawar no.42","","","","Yogyakarta"),
-- ("","Toko Buku Belajar Bersama","jalan cigantri No.112","Lengkong","","","Bandung"),

-- CREATE TABLE pembeli(
-- 	kd_beli VARCHAR(15)PRIMARY KEY,
-- 	nm_beli VARCHAR(20),
-- 	almt_beli VARCHAR(35),
-- 	nm_barang	VARCHAR(20),
-- 	jml_barang TINYINT,
-- 	nm_pegawai VARCHAR(18),
-- 	jab_pegawai VARCHAR(18),
-- 	tgl_pesan DATETIME,
-- 	cttn_pesan VARCHAR(50)
-- );

-- INSERT INTO pembeli VALUES
-- ("","Toko Permata indah","Jalan Mawar No.42, Yogyakarta","Meja Belajar","3","Agung","")


	-- SELECT kd_beli,
	-- 		almt_beli,
	-- 		nm_barang,
	-- 		jml_barang AS jml_barang,
	-- 		nm_pegawai AS nm_pegawai,
	-- 		jab_pegawai AS jab_pegawai,
	-- 		tgl_pesan AS tgl_pesan,
	-- 		cttn_pesan AS cttn_pesan
	-- FROM pembeli;

-- ALTER TABLE pembeli
-- 	ADD COLUMN jml_barang VARCHAR(20);
-- -- ALTER TABLE pembeli
-- INSERT INTO almt_beli VALUES
-- 	("jlnAlmt"),
-- 	("kecAlmt"),
-- 	("kdposAlmt"),
-- 	("kotaAlmt"),
-- 	("propAlmt");

