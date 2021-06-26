--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-06-26 16:04:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3001 (class 0 OID 16589)
-- Dependencies: 201
-- Data for Name: materiale; Type: TABLE DATA; Schema: public; Owner: ionut
--

DROP TYPE IF EXISTS categ_materiale;
DROP TYPE IF EXISTS tipuri_materiale;
DROP TYPE IF EXISTS culori;

CREATE TYPE public.categ_materiale AS ENUM( 'constructii', 'amenajari');
CREATE TYPE public.tipuri_materiale AS ENUM('materiale constructii', 'izolatii', 'sanitare', 'amenajari interioare');
CREATE TYPE public.culori AS ENUM( 'negru', 'alb', 'bej', 'argintiu', 'maro', 'gri', 'rosu');

CREATE TABLE IF NOT EXISTS public.materiale (
   id serial PRIMARY KEY,
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   greutate INT NOT NULL CHECK (greutate>0),   
   tip_produs public.tipuri_materiale DEFAULT 'materiale constructii',
   categorie public.categ_materiale DEFAULT 'constructii',
   cu_livrare BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),
   culoare public.culori,
   materiale_componente VARCHAR [],
   data_adaugare TIMESTAMP DEFAULT current_timestamp
);

INSERT INTO public.materiale VALUES (1, 'Lavoar travertin', 'Lavoar din travertin de culoare bej', 170.50, 10, 'sanitare', 'amenajari', true, 'lavoar-rotund-travertin.png', 'bej', '{travertin}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (2, 'Lavoar dreptunghiular travertin', 'Lavoar din travertin, dreptunghiular, de culoare bej', 280.90, 12, 'sanitare', 'amenajari', true, 'lavoar-dreptunghiular-travertin.png', 'bej', '{travertin}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (3, 'Lavoar ceramic', 'Lavoar ceramic, dreptunghiular, de culoare alba', 140.90, 10, 'sanitare', 'amenajari', true, 'lavoar-ceramic.png', 'alb', '{ceramica}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (4, 'Lavoar portelan', 'Lavoar adanc din portelan de culoare alba', 250.50, 11, 'sanitare', 'amenajari', true, 'lavoar-veronia.png', 'alb', '{portelan}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (5, 'Baterie chiuveta venezia', 'Baterie chiuveta din alama, 15cm, culoare bej', 195.00, 5, 'sanitare', 'amenajari', true, 'baterie-chiuveta-venezia.png', 'bej', '{alama}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (6, 'Baterie chiuveta avital', 'Baterie chiuveta din inox, 17cm, culoare neagra', 185.50, 5, 'sanitare', 'amenajari', true, 'avital-baterie-chiuveta.png', 'negru', '{inox}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (7, 'Baterie chiuveta grohe', 'Baterie chiuveta din inox, 17cm, culoare argintie', 150.00, 4, 'sanitare', 'amenajari', true, 'grohe-baterie-chiuveta.png', 'argintiu', '{inox}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (8, 'Silicon sanitar alb', 'Silicon sanitar, 280ml, culoare alba', 30.50, 1, 'sanitare', 'amenajari', true, 'silicon.png', 'alb', '{silicon,"colorant alb"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (9, 'Silicon sanitar bej', 'Silicon sanitar, 280ml, culoare bej', 35.50, 1, 'sanitare', 'amenajari', true, 'silicon_maro.png', 'bej', '{silicon,"colorant maro"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (10, 'Usa intrare metalica London', 'Usa intrare metalica, 200cm x 130cm, culoare neagra', 1000.00, 50, 'amenajari interioare', 'amenajari', true, 'usa-intrare-metalica.png', 'negru', '{fier,"sticla mata"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (11, 'Usa intrare metalica Megadoor', 'Usa intrare metalica, 200cm x 100cm, culoare maro', 985.90, 50, 'amenajari interioare', 'amenajari', true, 'usa-intrare-metalica-2.png', 'maro', '{fier,"sticla mata"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (12, 'Usa interior lemn', 'Usa interior dubla, 200cm x 200cm, culoare alba', 670.50, 30, 'amenajari interioare', 'amenajari', true, 'hinged-doors-2709566_640.png', 'alb', '{lemn}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (13, 'Parchet stratificat', 'Cutie parchet stratificat, 40 placi, dimensiune placa: 1380 x 193 mm, culoare maro', 185.50, 20, 'amenajari interioare', 'amenajari', true, 'parchet-lemn-stratificat.png', 'maro', '{"lemn brad",lac}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (14, 'Parchet triplustratificat', 'Cutie parchet triplustratificat, 30 placi, dimensiune placa: 1380 x 193 mm, culoare gri', 200.00, 20, 'amenajari interioare', 'amenajari', true, 'parchet-triplustratificat.png', 'gri', '{"lemn stejar",lac}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (15, 'Dusumea rasinoasa', 'Placa dusumea rasinoasa din lemn netratat, dimensiune placa: 1400 x 200 mm', 30.50, 2, 'amenajari interioare', 'amenajari', true, 'dusumea-rasinoasa.png', 'bej', '{"lemn brad"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (16, 'Gresie agora', 'Pachet gresie agora, 20 bucati, dimensiune placa: 400 x 400 mm', 180.50, 20, 'amenajari interioare', 'amenajari', true, 'gresie-agora.png', 'bej', '{"gresie naturala"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (17, 'Gresie portelanata', 'Pachet gresie portelanata cu aspect de beton, 20 bucati, dimensiune placa: 400 x 400 mm', 190.00, 20, 'amenajari interioare', 'amenajari', true, 'gresie-portelanata-aspect-beton.png', 'gri', '{"gresie portelanata"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (18, 'Gresie theain', 'Pachet gresie neagra cu insertii, 20 bucati, dimensiune placa: 400 x 400 mm', 200.00, 20, 'amenajari interioare', 'amenajari', true, 'gresie-theain-black.png', 'negru', '{gresie}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (19, 'Caramida aparenta', 'Pachet caramida aparent pentru decor, 100 bucati, dimensiune placa: 150 x 50 mm', 500.00, 30, 'amenajari interioare', 'amenajari', true, 'caramida-aparenta.png', 'bej', '{ipsos,vopsea}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (20, 'Tigla beton', 'Pachet tigla beton rosie, 100 bucati, dimensiune placa: 300 x 200 mm', 1000.00, 100, 'materiale constructii', 'constructii', false, 'tigla-beton-rosu.png', 'rosu', '{beton,vopsea}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (21, 'Tigla ceramica', 'Pachet Tigla ceramica teracota, 100 bucati, dimensiune placa: 300 x 200 mm', 1500.00, 100, 'materiale constructii', 'constructii', false, 'tigla-ceramica-teracota.png', 'rosu', '{teracota}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (22, 'Etrier din fier', 'Etrier din fier, dimensiune: 100 x 100 mm', 10.00, 1, 'materiale constructii', 'constructii', true, 'etrieri.png', 'negru', '{fier}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (23, 'Bara otel fasonat', 'Bara otel fasonat, dimensiune: 2m lungime, 1cm grosime', 50.00, 7, 'materiale constructii', 'constructii', false, 'bara-otel-fasonat.png', 'negru', '{"otel fasonat"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (24, 'Teava otel', 'Teava dreptunghiulara otel, dimensiune: 2m lungime, 5cm x 7cm grosime', 80.50, 15, 'materiale constructii', 'constructii', false, 'teava-dreptunghiulara-otel.png', 'negru', '{otel}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (25, 'Teava aluminiu', 'Teava patrat aluminiu, dimensiune: 2m lungime, 5cm x 5cm grosime', 70.00, 6, 'materiale constructii', 'constructii', false, 'teava-aluminiu-patrata.png', 'argintiu', '{aluminiu}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (26, 'Plasa sudata', 'Plasa sudata fier, dimensiune: 2m x 2m', 181.00, 25, 'materiale constructii', 'constructii', false, 'plasa-sudata-cnstructii.png', 'gri', '{fier}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (27, 'Plasa sapa', 'Plasa sapa fier, dimensiune: 2m x 2m', 150.00, 15, 'materiale constructii', 'constructii', false, 'plasa.png', 'gri', '{fier}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (28, 'Banda adeziva', 'Banda adeziva, dimensiune: 20m lungime, 10cm latime', 55.00, 2, 'materiale constructii', 'constructii', true, 'banda-adeziva.png', 'alb', '{pvc}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (29, 'BCA', 'Bax BCA Ytong cu catare, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 750.00, 35, 'materiale constructii', 'constructii', false, 'bca-ytong.png', 'alb', '{bca}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (30, 'Beton baumit', 'Sac beton baumit, greutate: 20kg', 100.00, 20, 'materiale constructii', 'constructii', true, 'beton-baumit.png', 'gri', '{beton}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (31, 'Mortar tencuiala', 'Sac mortar tencuiala, greutate: 20kg', 80.00, 20, 'materiale constructii', 'constructii', true, 'mortar-tencuiala.png', 'gri', '{mortar}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (32, 'Glet baumit', 'Sac beton baumit, greutate: 20kg', 85.00, 20, 'materiale constructii', 'constructii', true, 'glet-baumit.png', 'gri', '{glet}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (33, 'Ciment SapaBet', 'Sac ciment SapaBet, greutate: 25kg', 125.00, 25, 'materiale constructii', 'constructii', true, 'ciment sapabet.png', 'gri', '{ciment}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (34, 'Sapa autonivelanta Ceresit', 'Sac sapa autonivelanta Ceresit, greutate: 20kg', 90.00, 20, 'materiale constructii', 'constructii', false, 'sapa-autonivelanta-ceresit.png', 'gri', '{sapa}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (35, 'Tencuiala decorativa', 'Sac tencuiala decorativa minerala, greutate: 20kg', 95.00, 20, 'amenajari interioare', 'amenajari', true, 'tencuiala-decorativa-minerala.png', 'gri', '{"tencuiala minerala"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (36, 'Caramida porotherm cu catare', 'Bax caramida porotherm cu catare, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 300.00, 50, 'materiale constructii', 'constructii', false, 'caramida-porotherm.png', 'rosu', '{ceramica}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (37, 'Caramida porotherm', 'Bax caramida porotherm, 50 bucati, dimensiune bucata: 30cm x 20cm x 15cm', 250.00, 50, 'materiale constructii', 'constructii', false, 'brick-258938_640.png', 'rosu', '{ceramica}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (38, 'Buiandrug', 'Bax buiandrugi, 10 bucati, dimensiune bucata: 100cm x 10cm x 15cm', 200.00, 50, 'materiale constructii', 'constructii', false, 'buiandrug-porotherm.png', 'rosu', '{ceramica,ciment}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (39, 'Grinda lemn', 'Grinda patrata din lemn netratat, dimensiune: 2m lungime, 10cm x 10cm', 125.00, 35, 'materiale constructii', 'constructii', false, 'grinda-lemn.png', 'bej', '{"lemn fag"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (40, 'Sindrila bituminoasa', 'Placa sindrila bituminoasa, dimensiune: 2m x 2m', 200.00, 15, 'materiale constructii', 'constructii', false, 'roof-2805712_640.png', 'rosu', '{bitum}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (41, 'Clema coama tigla', 'Clema coama tigla, dimensiune: 15cm', 20.00, 1, 'materiale constructii', 'constructii', true, 'cleme-coama-tigla.png', 'rosu', '{fier}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (42, 'Aditiv impermeabilizare beton', 'Aditiv impermeabilizare beton, cantitate: 10L', 70.00, 15, 'izolatii', 'constructii', true, 'aditiv-impermeabilizare-beton.png', 'gri', '{"aditiv beton"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (43, 'Banda de etansare', 'Banda de etansare neagra, dimensiune: 20m lungime, 10cm latime', 65.70, 1, 'izolatii', 'constructii', true, 'banda-de-etansare.png', 'negru', '{pvc}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (44, 'Folie termoizolanta', 'Rola folie bariera de vapori termoizolanta si fonoizolanta, dimensiune: 6m x 2m', 385.90, 35, 'izolatii', 'constructii', true, 'folie-bariera-de-vapori-termoizolanta-si-fonoizolanta.png', 'gri', '{"folie termoizolanta"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (45, 'Polistiren extrudat', 'Bax placi polistiren extrudat, 10 bucati, dimensiune placa: 200cm x 150cm', 100.00, 5, 'izolatii', 'constructii', true, 'polistiren-extrudat.png', 'alb', '{polistiren}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (46, 'Vata minerala de sticla', 'Rola vata minerala de sticla, dimensiune: 10m X 1.5m', 375.40, 30, 'izolatii', 'constructii', true, 'vata-minerala-de-sticla.png', 'alb', '{"vata minerala de sticla"}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (47, 'Placa gips carton', 'Bax placi gips carton, 20 bucati, dimensiune placa: 2m  1.5m', 350.00, 200, 'izolatii', 'constructii', false, 'placa-gips-carton.png', 'alb', '{gips,carton}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (48, 'Hidroizolatie flexibila', 'Galeata hidroizolatie flexibila, cantitate: 15L', 86.70, 20, 'izolatii', 'constructii', true, 'hidroizolatie-flexibila-ceresit.png', 'gri', '{hidroizolatie}', '2021-05-30 14:25:45.293937');
INSERT INTO public.materiale VALUES (49, 'Spuma poliuretanica', 'Tub spuma poliuretanica, cantitate: 400ml', 90.00, 3, 'izolatii', 'constructii', true, 'spuma-poliuretanica.png', 'alb', '{"spuma poliuretanica"}', '2021-05-30 14:25:45.293937');


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 200
-- Name: materiale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ionut
--

SELECT pg_catalog.setval('public.materiale_id_seq', 49, true);


-- Completed on 2021-06-26 16:04:51

--
-- PostgreSQL database dump complete
--

