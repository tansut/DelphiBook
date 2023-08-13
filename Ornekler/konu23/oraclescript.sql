create table Yazarlar (
 YazarKodu Number(9) not null,
 YazarAdi Varchar2(30) not null,
 primary key (YazarKodu)
);

create index YazarAdi_Index on Yazarlar(YazarAdi);

create table kitaplar (
 KitapKodu Number(9) not null,
 YazarKodu Number(9) not null,
 KitapAdi varchar2(100) not null,
 primary key (KitapKodu)
);

create index KitapAdiIndex on Kitaplar(KitapAdi);

create table kiracilar (
 KiraciKodu Number(9) not null,
 KiraciAdi varchar2(30) not null,
 KiraciYasi number(3),
 primary key(KiraciKodu)
);

create table kiralanankitaplar (
 kitapkodu number(4) not null,
 kiracikodu number(4) not null,
 kiratarihi date not null,
 primary key(kitapkodu,kiracikodu, kiratarihi)
);



insert into Yazarlar (YazarKodu, YazarAdi) Values(1, 'Ayþe Kulin');
insert into Yazarlar (YazarKodu, YazarAdi) Values(2, 'Buket Uzuner');
insert into Yazarlar (YazarKodu, YazarAdi) Values(3, 'Mine Urgan');
insert into Yazarlar (YazarKodu, YazarAdi) Values(4, 'Rýfat Ilgaz');
insert into Yazarlar (YazarKodu, YazarAdi) Values(5, 'Aziz Nesin');
insert into Yazarlar (YazarKodu, YazarAdi) Values(6, 'Peyami Safa');
insert into Yazarlar (YazarKodu, YazarAdi) Values(7, 'Ömer Seyfettin');
insert into Yazarlar (YazarKodu, YazarAdi) Values(8, 'Orhan Pamuk');
insert into Yazarlar (YazarKodu, YazarAdi) Values(9, 'Yaþar Kemal');
insert into Yazarlar (YazarKodu, YazarAdi) Values(10, 'Doðan Cüceloðlu');
insert into Yazarlar (YazarKodu, YazarAdi) Values(11, 'Can Dündar');

insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(1,2,'Kumral Ada Mavi Tuna');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(2,3,'Bir Dinazorun Gezileri');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(3,7,'Bomba');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(4,4,'Hababam Sýnýfý');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(5,1,'Sevdalinka');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(6,3,'Bir Dinazorun Anýlarý');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(7,8,'Yeni Hayat');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(8,6,'Yalnýzlýk');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(9,9,'Ýnce Memed');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(10,5,'Zübük');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(11,10,'Savaþçý');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(12,1,'Adý Aylin');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(13,8,'Beyaz Kale');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(14,7,'Pranga');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(15,9,'Aðrý Daðý Efsanesi');
insert into Kitaplar (KitapKodu, YazarKodu, KitapAdi) Values(16,10,'Ýçimizdeki Çocuk');


insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(1,1,'01/09/1999');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(2,1,'12/01/2000');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(3,2,'20/10/1998');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(4,5,'30/01/2001');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(5,1,'09/11/2000');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(6,3,'22/07/1998');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(7,3,'18/10/1999');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(8,4,'12/01/1999');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(9,5,'23/04/2000');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(10,4,'26/06/1998');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(11,1,'11/11/2000');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(12,4,'12/09/1998');
insert into KiralananKitaplar(KitapKodu, KiraciKodu, KiraTarihi) Values(13,4,'24/05/2000');

insert into Kiracilar(KiraciKodu, KiraciAdi, KiraciYasi) Values(1,'Feride Yavuz', null);
insert into Kiracilar(KiraciKodu, KiraciAdi, KiraciYasi) Values(2,'Özgür Þahin', 26);
insert into Kiracilar(KiraciKodu, KiraciAdi, KiraciYasi) Values(3,'Gönül Bölük', null);
insert into Kiracilar(KiraciKodu, KiraciAdi, KiraciYasi) Values(4,'Selçuk Aydýn', 29);
insert into Kiracilar(KiraciKodu, KiraciAdi, KiraciYasi) Values(5,'Celal Yýldýrým', null);	

