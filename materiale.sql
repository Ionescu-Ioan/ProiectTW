DROP TYPE IF EXISTS categ_materiale;
DROP TYPE IF EXISTS tipuri_materiale;
DROP TYPE IF EXISTS culori;

CREATE TYPE categ_materiale AS ENUM( 'constructii', 'amenajari');
CREATE TYPE tipuri_materiale AS ENUM('materiale constructii', 'izolatii', 'sanitare', 'amenajari interioare');
CREATE TYPE culori AS ENUM( 'negru', 'alb', 'bej', 'argintiu', 'maro', 'gri', 'rosu');

CREATE TABLE IF NOT EXISTS materiale (
   id serial PRIMARY KEY,
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   greutate INT NOT NULL CHECK (greutate>0),   
   tip_produs tipuri_materiale DEFAULT 'materiale constructii',
   categorie categ_materiale DEFAULT 'constructii',
   cu_livrare BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),
   culoare culori,
   materiale_componente VARCHAR [],
   data_adaugare TIMESTAMP DEFAULT current_timestamp
);

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Lavoar travertin', 'Lavoar din travertin de culoare bej', 170.5 , 10, 'sanitare', 'amenajari', True,'lavoar-rotund-travertin.png', 'bej', '{"travertin"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Lavoar dreptunghiular travertin', 'Lavoar din travertin, dreptunghiular, de culoare bej', 280.9 , 12, 'sanitare', 'amenajari', True,'lavoar-dreptunghiular-travertin.png', 'bej', '{"travertin"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Lavoar ceramic', 'Lavoar ceramic, dreptunghiular, de culoare alba', 140.9 , 10, 'sanitare', 'amenajari', True,'lavoar-ceramic.png', 'alb', '{"ceramica"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Lavoar portelan', 'Lavoar adanc din portelan de culoare alba', 250.5 , 11, 'sanitare', 'amenajari', True,'lavoar-veronia.png', 'alb', '{"portelan"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Baterie chiuveta venezia', 'Baterie chiuveta din alama, 15cm, culoare bej', 195.0 , 5, 'sanitare', 'amenajari', True,'baterie-chiuveta-venezia.png', 'bej', '{"alama"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Baterie chiuveta avital', 'Baterie chiuveta din inox, 17cm, culoare neagra', 185.5 , 5, 'sanitare', 'amenajari', True,'avital-baterie-chiuveta.png', 'negru', '{"inox"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Baterie chiuveta grohe', 'Baterie chiuveta din inox, 17cm, culoare argintie', 150.0 , 4, 'sanitare', 'amenajari', True,'grohe-baterie-chiuveta.png', 'argintiu', '{"inox"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Silicon sanitar alb', 'Silicon sanitar, 280ml, culoare alba', 30.5 , 1, 'sanitare', 'amenajari', True,'silicon.png', 'alb', '{"silicon", "colorant alb"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Silicon sanitar bej', 'Silicon sanitar, 280ml, culoare bej', 35.5 , 1, 'sanitare', 'amenajari', True,'silicon_maro.png', 'bej', '{"silicon", "colorant maro"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Usa intrare metalica London', 'Usa intrare metalica, 200cm x 130cm, culoare neagra', 1000.0 , 50, 'amenajari interioare', 'amenajari', True,'usa-intrare-metalica.png', 'negru', '{"fier", "sticla mata"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Usa intrare metalica Megadoor', 'Usa intrare metalica, 200cm x 100cm, culoare maro', 985.9 , 50, 'amenajari interioare', 'amenajari', True,'usa-intrare-metalica-2.png', 'maro', '{"fier", "sticla mata"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Usa interior lemn', 'Usa interior dubla, 200cm x 200cm, culoare alba', 670.5 , 30, 'amenajari interioare', 'amenajari', True,'hinged-doors-2709566_640.png', 'alb', '{"lemn"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Parchet stratificat', 'Cutie parchet stratificat, 40 placi, dimensiune placa: 1380 x 193 mm, culoare maro', 185.5 , 20, 'amenajari interioare', 'amenajari', True,'parchet-lemn-stratificat.png', 'maro', '{"lemn brad", "lac"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Parchet triplustratificat', 'Cutie parchet triplustratificat, 30 placi, dimensiune placa: 1380 x 193 mm, culoare gri', 200.0 , 20, 'amenajari interioare', 'amenajari', True,'parchet-triplustratificat.png', 'gri', '{"lemn stejar", "lac"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Dusumea rasinoasa', 'Placa dusumea rasinoasa din lemn netratat, dimensiune placa: 1400 x 200 mm', 30.5 , 2, 'amenajari interioare', 'amenajari', True,'dusumea-rasinoasa.png', 'bej', '{"lemn brad"}');



INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Gresie agora', 'Pachet gresie agora, 20 bucati, dimensiune placa: 400 x 400 mm', 180.5 , 20, 'amenajari interioare', 'amenajari', True,'gresie-agora.png', 'bej', '{"gresie naturala"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Gresie portelanata', 'Pachet gresie portelanata cu aspect de beton, 20 bucati, dimensiune placa: 400 x 400 mm', 190.0 , 20, 'amenajari interioare', 'amenajari', True,'gresie-portelanata-aspect-beton.png', 'gri', '{"gresie portelanata"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Gresie theain', 'Pachet gresie neagra cu insertii, 20 bucati, dimensiune placa: 400 x 400 mm', 200.0 , 20, 'amenajari interioare', 'amenajari', True,'gresie-theain-black.png', 'negru', '{"gresie"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Caramida aparenta', 'Pachet caramida aparent pentru decor, 100 bucati, dimensiune placa: 150 x 50 mm', 500.0 , 30, 'amenajari interioare', 'amenajari', True,'caramida-aparenta.png', 'bej', '{"ipsos", "vopsea"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Tigla beton', 'Pachet tigla beton rosie, 100 bucati, dimensiune placa: 300 x 200 mm', 1000.0 , 100, 'materiale constructii', 'constructii', False,'tigla-beton-rosu.png', 'rosu', '{"beton", "vopsea"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Tigla ceramica', 'Pachet Tigla ceramica teracota, 100 bucati, dimensiune placa: 300 x 200 mm', 1500.0 , 100, 'materiale constructii', 'constructii', False,'tigla-ceramica-teracota.png', 'rosu', '{"teracota"}');


INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Etrier din fier', 'Etrier din fier, dimensiune: 100 x 100 mm', 10.0 , 1, 'materiale constructii', 'constructii', True,'etrieri.png', 'negru', '{"fier"}');



INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Bara otel fasonat', 'Bara otel fasonat, dimensiune: 2m lungime, 1cm grosime', 50.0 , 7, 'materiale constructii', 'constructii', False,'bara-otel-fasonat.png', 'negru', '{"otel fasonat"}');


INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Teava otel', 'Teava dreptunghiulara otel, dimensiune: 2m lungime, 5cm x 7cm grosime', 80.5 , 15, 'materiale constructii', 'constructii', False,'teava-dreptunghiulara-otel.png', 'negru', '{"otel"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Teava aluminiu', 'Teava patrat aluminiu, dimensiune: 2m lungime, 5cm x 5cm grosime', 70.0 , 6, 'materiale constructii', 'constructii', False,'teava-aluminiu-patrata.png', 'argintiu', '{"aluminiu"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Plasa sudata', 'Plasa sudata fier, dimensiune: 2m x 2m', 181.0 , 25, 'materiale constructii', 'constructii', False,'plasa-sudata-cnstructii.png', 'gri', '{"fier"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Plasa sapa', 'Plasa sapa fier, dimensiune: 2m x 2m', 150.0 , 15, 'materiale constructii', 'constructii', False,'plasa.png', 'gri', '{"fier"}');





INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Banda adeziva', 'Banda adeziva, dimensiune: 20m lungime, 10cm latime', 55.0 , 2, 'materiale constructii', 'constructii', True,'banda-adeziva.png', 'alb', '{"pvc"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('BCA', 'Bax BCA Ytong cu catare, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 750.0 , 35, 'materiale constructii', 'constructii', False,'bca-ytong.png', 'alb', '{"bca"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Beton baumit', 'Sac beton baumit, greutate: 20kg', 100.0 , 20, 'materiale constructii', 'constructii', True,'beton-baumit.png', 'gri', '{"beton"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Mortar tencuiala', 'Sac mortar tencuiala, greutate: 20kg', 80.0 , 20, 'materiale constructii', 'constructii', True,'mortar-tencuiala.png', 'gri', '{"mortar"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Glet baumit', 'Sac beton baumit, greutate: 20kg', 85.0 , 20, 'materiale constructii', 'constructii', True,'glet-baumit.png', 'gri', '{"glet"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Ciment SapaBet', 'Sac ciment SapaBet, greutate: 25kg', 125.0 , 25, 'materiale constructii', 'constructii', True,'ciment sapabet.png', 'gri', '{"ciment"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Sapa autonivelanta Ceresit', 'Sac sapa autonivelanta Ceresit, greutate: 20kg', 90.0 , 20, 'materiale constructii', 'constructii', False,'sapa-autonivelanta-ceresit.png', 'gri', '{"sapa"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Tencuiala decorativa', 'Sac tencuiala decorativa minerala, greutate: 20kg', 95.0 , 20, 'amenajari interioare', 'amenajari', True,'tencuiala-decorativa-minerala.png', 'gri', '{"tencuiala minerala"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Caramida porotherm cu catare', 'Bax caramida porotherm cu catare, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 300.0 , 50, 'materiale constructii', 'constructii', False,'caramida-porotherm.png', 'rosu', '{"ceramica"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Caramida porotherm', 'Bax caramida porotherm, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 250.0 , 50, 'materiale constructii', 'constructii', False,'brick-258938_640.png', 'rosu', '{"ceramica"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Buiandrug', 'Bax buiandrugi, 10 bucati, dimensiune bucata: 100cm x 10cm x 15cm', 200.0 , 50, 'materiale constructii', 'constructii', False,'buiandrug-porotherm.png', 'rosu', '{"ceramica", "ciment"}');


INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Grinda lemn', 'Grinda patrata din lemn netratat, dimensiune: 2m lungime, 10cm x 10cm', 125.0 , 35, 'materiale constructii', 'constructii', False,'grinda-lemn.png', 'bej', '{"lemn fag"}');


INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Sindrila bituminoasa', 'Placa sindrila bituminoasa, dimensiune: 2m x 2m', 200.0 , 15, 'materiale constructii', 'constructii', False,'roof-2805712_640.png', 'rosu', '{"bitum"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Clema coama tigla', 'Clema coama tigla, dimensiune: 15cm', 20.0 , 1, 'materiale constructii', 'constructii', True,'cleme-coama-tigla.png', 'rosu', '{"fier"}');




INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Aditiv impermeabilizare beton', 'Aditiv impermeabilizare beton, cantitate: 10L', 70.0 , 15, 'izolatii', 'constructii', True,'aditiv-impermeabilizare-beton.png', 'gri', '{"aditiv beton"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Banda de etansare', 'Banda de etansare neagra, dimensiune: 20m lungime, 10cm latime', 65.7 , 1, 'izolatii', 'constructii', True,'banda-de-etansare.png', 'negru', '{"pvc"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Folie termoizolanta', 'Rola folie bariera de vapori termoizolanta si fonoizolanta, dimensiune: 6m x 2m', 385.9 , 35, 'izolatii', 'constructii', True,'folie-bariera-de-vapori-termoizolanta-si-fonoizolanta.png', 'gri', '{"folie termoizolanta"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Polistiren extrudat', 'Bax placi polistiren extrudat, 10 bucati, dimensiune placa: 200cm x 150cm', 100.0 , 5, 'izolatii', 'constructii', True,'polistiren-extrudat.png', 'alb', '{"polistiren"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Vata minerala de sticla', 'Rola vata minerala de sticla, dimensiune: 10m X 1.5m', 375.4 , 30, 'izolatii', 'constructii', True,'vata-minerala-de-sticla.png', 'alb', '{"vata minerala de sticla"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Placa gips carton', 'Bax placi gips carton, 20 bucati, dimensiune placa: 2m  1.5m', 350.0 , 200, 'izolatii', 'constructii', False,'placa-gips-carton.png', 'alb', '{"gips", "carton"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Hidroizolatie flexibila', 'Galeata hidroizolatie flexibila, cantitate: 15L', 86.7 , 20, 'izolatii', 'constructii', True,'hidroizolatie-flexibila-ceresit.png', 'gri', '{"hidroizolatie"}');

INSERT into materiale (nume,descriere,pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente) VALUES 
('Spuma poliuretanica', 'Tub spuma poliuretanica, cantitate: 400ml', 90.0 , 3, 'izolatii', 'constructii', True,'spuma-poliuretanica.png', 'alb', '{"spuma poliuretanica"}');