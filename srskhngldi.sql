--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    entrepreneur_id integer,
    account_number character varying(50) NOT NULL,
    bank_name character varying(255) NOT NULL,
    balance numeric(15,2) DEFAULT 0.00
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    entrepreneur_id integer,
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(20)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    entrepreneur_id integer,
    name character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    salary numeric(15,2) NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: entrepreneurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrepreneurs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    tax_id character varying(20) NOT NULL,
    registration_date date NOT NULL
);


ALTER TABLE public.entrepreneurs OWNER TO postgres;

--
-- Name: entrepreneurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrepreneurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrepreneurs_id_seq OWNER TO postgres;

--
-- Name: entrepreneurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrepreneurs_id_seq OWNED BY public.entrepreneurs.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    entrepreneur_id integer,
    expense_date date NOT NULL,
    amount numeric(15,2) NOT NULL,
    category character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expenses_id_seq OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_items (
    id integer NOT NULL,
    invoice_id integer,
    description text NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(15,2) NOT NULL
);


ALTER TABLE public.invoice_items OWNER TO postgres;

--
-- Name: invoice_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_items_id_seq OWNER TO postgres;

--
-- Name: invoice_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_items_id_seq OWNED BY public.invoice_items.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    entrepreneur_id integer,
    issue_date date NOT NULL,
    due_date date NOT NULL,
    total_amount numeric(15,2) NOT NULL,
    status character varying(20),
    CONSTRAINT invoices_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'overdue'::character varying])::text[])))
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    invoice_id integer,
    payment_date date NOT NULL,
    amount numeric(15,2) NOT NULL,
    method character varying(50) NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: purchase_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_items (
    id integer NOT NULL,
    purchase_id integer,
    description text NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(15,2) NOT NULL
);


ALTER TABLE public.purchase_items OWNER TO postgres;

--
-- Name: purchase_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_items_id_seq OWNER TO postgres;

--
-- Name: purchase_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_items_id_seq OWNED BY public.purchase_items.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    supplier_id integer,
    purchase_date date NOT NULL,
    total_amount numeric(15,2) NOT NULL
);


ALTER TABLE public.purchases OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchases_id_seq OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    entrepreneur_id integer,
    report_date date NOT NULL,
    report_type character varying(50) NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_id_seq OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaries (
    id integer NOT NULL,
    employee_id integer,
    payment_date date NOT NULL,
    amount numeric(15,2) NOT NULL
);


ALTER TABLE public.salaries OWNER TO postgres;

--
-- Name: salaries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salaries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salaries_id_seq OWNER TO postgres;

--
-- Name: salaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salaries_id_seq OWNED BY public.salaries.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    entrepreneur_id integer,
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(20)
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: taxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxes (
    id integer NOT NULL,
    entrepreneur_id integer,
    tax_type character varying(50) NOT NULL,
    tax_rate numeric(5,2) NOT NULL,
    due_date date NOT NULL,
    status character varying(20),
    CONSTRAINT taxes_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.taxes OWNER TO postgres;

--
-- Name: taxes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxes_id_seq OWNER TO postgres;

--
-- Name: taxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxes_id_seq OWNED BY public.taxes.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    account_id integer,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    amount numeric(15,2) NOT NULL,
    transaction_type character varying(10),
    description text,
    CONSTRAINT transactions_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['credit'::character varying, 'debit'::character varying])::text[])))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: entrepreneurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrepreneurs ALTER COLUMN id SET DEFAULT nextval('public.entrepreneurs_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: invoice_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items ALTER COLUMN id SET DEFAULT nextval('public.invoice_items_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: purchase_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_items ALTER COLUMN id SET DEFAULT nextval('public.purchase_items_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: salaries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries ALTER COLUMN id SET DEFAULT nextval('public.salaries_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: taxes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes ALTER COLUMN id SET DEFAULT nextval('public.taxes_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, entrepreneur_id, account_number, bank_name, balance) FROM stdin;
1	1	KZ123456789	Halyk Bank	50000.00
2	2	KZ987654321	Kaspi Bank	120000.50
3	3	KZ456789123	Forte Bank	75000.75
4	4	KZ321654987	Eurasian Bank	95000.00
5	5	KZ654123789	ATF Bank	67000.25
6	6	KZ147258369	Jusan Bank	110000.80
7	7	KZ369852147	Sber Bank	89000.00
8	8	KZ951753852	Bank CenterCredit	45000.90
9	9	KZ753159852	Alfa Bank	130000.60
10	10	KZ258741369	Home Credit Bank	60000.10
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, entrepreneur_id, name, email, phone) FROM stdin;
1	1	ТОО "МаркетГрупп"	info@marketgroup.kz	+77011234567
2	2	ИП "ДизайнСтудия"	contact@designstudio.kz	+77029876543
3	3	АО "БизнесТрейд"	support@businesstrade.kz	+77035678912
4	4	ТОО "Финансовый Консалтинг"	finance@consult.kz	+77042345678
5	5	ИП "МедиаПростор"	hello@mediaprostor.kz	+77058901234
6	6	АО "ТехноИнвест"	sales@techinvest.kz	+77063456789
7	7	ТОО "Логистика Плюс"	logistics@plus.kz	+77074567890
8	8	ИП "Рекламное Агентство"	ads@agency.kz	+77081234567
9	9	АО "Строительные Решения"	build@solutions.kz	+77092345678
10	10	ТОО "Ресторанный Холдинг"	info@restaurant.kz	+77103456789
11	1	ТОО "АстанаСнаб"	info@astanasnab.kz	+77011234567
12	2	ИП "Доставка+”	contact@dostavkaplus.kz	+77022345678
13	3	ТОО "Розница KZ"	sales@roznicakz.kz	+77033456789
14	4	ТОО "ОптТрейд"	support@opttrade.kz	+77044567890
15	5	ИП "СтройМатериалы"	manager@stroymat.kz	+77055678901
16	6	ТОО "АвтоПарт"	parts@avtopart.kz	+77066789012
17	7	ИП "Флора Дизайн"	flora@design.kz	+77077890123
18	8	ТОО "ЭлектроМаркет"	info@elektromarket.kz	+77088901234
19	9	ИП "АгроСнаб"	contact@agrosnab.kz	+77099012345
20	10	ТОО "Мебельный Центр"	sales@mebel.kz	+77100123456
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, entrepreneur_id, name, "position", salary) FROM stdin;
1	1	Иван Иванов	Бухгалтер	350000.00
2	2	Петр Петров	Менеджер	250000.00
3	3	Сергей Сергеев	Водитель	200000.00
4	4	Анна Смирнова	Офис-менеджер	220000.00
5	5	Елена Козлова	Программист	500000.00
6	6	Дмитрий Соколов	Техник	280000.00
7	7	Мария Миронова	Секретарь	210000.00
8	8	Олег Васильев	Юрист	450000.00
9	9	Виктор Кузнецов	Аналитик	370000.00
10	10	Алексей Морозов	Директор	700000.00
\.


--
-- Data for Name: entrepreneurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrepreneurs (id, name, tax_id, registration_date) FROM stdin;
1	ИП Иванов	123456789	2020-05-10
2	ИП Петров	987654321	2021-07-15
3	ИП Сидоров	456789123	2019-03-22
4	ИП Ким	321654987	2022-01-05
5	ИП Ахметов	654123789	2023-08-19
6	ИП Алиев	147258369	2020-12-10
7	ИП Беков	369852147	2021-06-30
8	ИП Ермеков	951753852	2018-11-12
9	ИП Омаров	753159852	2022-09-14
10	ИП Смагулов	258741369	2019-02-28
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (id, entrepreneur_id, expense_date, amount, category, description) FROM stdin;
1	1	2024-02-10	25000.00	Аренда	Аренда офиса
2	2	2024-03-12	15000.50	Коммунальные услуги	Оплата электроэнергии
3	3	2024-01-25	20000.00	Маркетинг	Реклама в соцсетях
4	4	2024-02-28	5000.75	Канцелярия	Покупка бумаги и ручек
5	5	2024-03-05	18000.00	Транспорт	Оплата бензина
6	6	2024-04-10	12000.20	Образование	Курсы для персонала
7	7	2024-05-15	9000.00	Развлечения	Корпоративное мероприятие
8	8	2024-06-20	35000.90	Техническое обслуживание	Ремонт оборудования
9	9	2024-07-30	6000.30	Программное обеспечение	Покупка лицензий
10	10	2024-08-10	22000.00	Охрана	Оплата услуг охранной фирмы
11	1	2024-01-10	15000.00	Аренда	Оплата аренды офиса
12	2	2024-02-15	5000.00	Коммунальные услуги	Оплата электроэнергии
13	3	2024-03-05	20000.00	Закупка сырья	Покупка материалов для производства
14	4	2024-04-22	7000.00	Маркетинг	Реклама в социальных сетях
15	5	2024-05-18	12000.00	Зарплата	Выплата зарплаты сотрудникам
16	6	2024-06-12	8000.00	Обслуживание	Ремонт оборудования
17	7	2024-07-29	4000.00	Офисные расходы	Закупка канцелярии
18	8	2024-08-20	10000.00	Логистика	Доставка товаров клиентам
19	9	2024-09-30	1500.00	Программное обеспечение	Оплата лицензии CRM
20	10	2024-10-25	6000.00	Обучение	Курсы повышения квалификации
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice_items (id, invoice_id, description, quantity, unit_price) FROM stdin;
1	1	Консультационные услуги	2	15000.00
2	2	Разработка веб-сайта	1	75000.50
3	3	Графический дизайн	3	10000.25
4	4	Маркетинговый анализ	1	100000.00
5	5	Продвижение в соцсетях	2	22500.00
6	6	Обучающий семинар	4	22500.20
7	7	Фотосъемка	1	60000.00
8	8	Копирайтинг	5	14000.90
9	9	Аудиторские услуги	2	60000.30
10	10	SEO-оптимизация	3	26666.70
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (id, entrepreneur_id, issue_date, due_date, total_amount, status) FROM stdin;
1	1	2024-01-10	2024-01-20	50000.00	pending
2	2	2024-02-05	2024-02-15	75000.50	paid
3	3	2024-03-12	2024-03-22	30000.75	overdue
4	4	2024-04-18	2024-04-28	100000.00	pending
5	5	2024-05-22	2024-06-01	45000.25	paid
6	6	2024-06-30	2024-07-10	90000.80	overdue
7	7	2024-07-15	2024-07-25	60000.00	pending
8	8	2024-08-08	2024-08-18	70000.90	paid
9	9	2024-09-01	2024-09-11	120000.60	overdue
10	10	2024-10-10	2024-10-20	80000.10	pending
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, invoice_id, payment_date, amount, method) FROM stdin;
1	1	2024-01-20	50000.00	Банковский перевод
2	2	2024-02-10	75000.50	Кредитная карта
3	3	2024-03-15	30000.75	Наличные
4	4	2024-04-25	100000.00	Электронный кошелек
5	5	2024-05-30	45000.25	Банковский перевод
6	6	2024-06-12	90000.80	Кредитная карта
7	7	2024-07-20	60000.00	Наличные
8	8	2024-08-18	70000.90	Электронный кошелек
9	9	2024-09-11	120000.60	Банковский перевод
10	10	2024-10-22	80000.10	Кредитная карта
\.


--
-- Data for Name: purchase_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_items (id, purchase_id, description, quantity, unit_price) FROM stdin;
11	1	Компьютерное оборудование	5	20000.00
12	2	Офисная мебель	10	7500.00
13	3	Бумага для принтера	50	1000.50
14	4	Программное обеспечение	2	60000.00
15	5	Мониторы	4	11250.06
16	6	Принтеры	3	30000.27
17	7	Кондиционеры	2	30000.00
18	8	Канцелярия	100	700.90
19	9	МФУ (Многофункциональные устройства)	1	130000.60
20	10	Лицензия на ПО	5	16000.02
\.


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchases (id, supplier_id, purchase_date, total_amount) FROM stdin;
1	1	2024-01-05	100000.00
2	2	2024-02-10	75000.50
3	3	2024-03-15	50000.75
4	4	2024-04-20	120000.00
5	5	2024-05-25	45000.25
6	6	2024-06-30	90000.80
7	7	2024-07-12	60000.00
8	8	2024-08-18	70000.90
9	9	2024-09-05	130000.60
10	10	2024-10-15	80000.10
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, entrepreneur_id, report_date, report_type, content) FROM stdin;
1	1	2024-01-15	Финансовый отчет	Отчет о доходах и расходах за январь 2024
2	2	2024-02-10	Налоговый отчет	Декларация по НДС за 1 квартал 2024
3	3	2024-03-05	Отчет о продажах	Данные о продажах за февраль 2024
4	4	2024-04-12	Бухгалтерский баланс	Анализ активов и пассивов компании
5	5	2024-05-18	Отчет по расходам	Отчет о расходах на материалы за апрель 2024
6	6	2024-06-25	Отчет о персонале	Численность сотрудников и выплаты зарплат
7	7	2024-07-07	Отчет по клиентам	Список новых клиентов за июнь 2024
8	8	2024-08-19	Отчет о прибыли	Прибыль за июль 2024
9	9	2024-09-23	Отчет по поставкам	Анализ закупок и поставок за август 2024
10	10	2024-10-30	Годовой отчет	Общий финансовый отчет за 2024 год
\.


--
-- Data for Name: salaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salaries (id, employee_id, payment_date, amount) FROM stdin;
1	1	2024-01-31	350000.00
2	2	2024-02-28	250000.00
3	3	2024-03-31	200000.00
4	4	2024-04-30	220000.00
5	5	2024-05-31	500000.00
6	6	2024-06-30	280000.00
7	7	2024-07-31	210000.00
8	8	2024-08-31	450000.00
9	9	2024-09-30	370000.00
10	10	2024-10-31	700000.00
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, entrepreneur_id, name, email, phone) FROM stdin;
1	1	ТОО "ТехСнаб"	info@techsnab.kz	+77012345678
2	2	ИП "Фурнитура KZ"	contact@furnitura.kz	+77023456789
3	3	ТОО "ЭлектроСнаб"	sales@elektrosnab.kz	+77034567890
4	4	ТОО "МедСнаб"	support@medsnab.kz	+77045678901
5	5	ИП "Продукты"	manager@produkty.kz	+77056789012
6	6	ТОО "МеталлоПрокат"	info@metall.kz	+77067890123
7	7	ИП "АвтоДетали"	parts@avtodetali.kz	+77078901234
8	8	ТОО "СтройКомплект"	info@stroykomplekt.kz	+77089012345
9	9	ИП "ОфисСнаб"	contact@officesnab.kz	+77090123456
10	10	ТОО "МебельСнаб"	sales@mebelsnab.kz	+77101234567
\.


--
-- Data for Name: taxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taxes (id, entrepreneur_id, tax_type, tax_rate, due_date, status) FROM stdin;
7	1	НДС	12.00	2024-03-15	pending
8	2	Подоходный налог	10.00	2024-04-10	paid
9	3	Социальный налог	5.00	2024-02-28	pending
10	4	Корпоративный налог	20.00	2024-05-05	pending
11	5	Налог на имущество	6.50	2024-06-20	paid
12	6	Экологический сбор	3.00	2024-07-15	pending
13	7	Лицензионный сбор	7.00	2024-08-01	paid
14	8	Транспортный налог	9.50	2024-09-12	pending
15	9	Акцизный налог	15.00	2024-10-25	pending
16	10	Таможенный сбор	8.00	2024-11-30	paid
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, account_id, transaction_date, amount, transaction_type, description) FROM stdin;
1	1	2025-03-05 13:35:37.210722	15000.00	credit	Поступление средств
2	2	2025-03-05 13:35:37.210722	20000.00	debit	Оплата аренды
3	3	2025-03-05 13:35:37.210722	5000.50	credit	Оплата от клиента
4	4	2025-03-05 13:35:37.210722	7500.00	debit	Покупка материалов
5	5	2025-03-05 13:35:37.210722	10000.00	credit	Продажа товара
6	6	2025-03-05 13:35:37.210722	3000.00	debit	Коммунальные платежи
7	7	2025-03-05 13:35:37.210722	18000.75	credit	Возврат средств
8	8	2025-03-05 13:35:37.210722	22000.90	debit	Закупка оборудования
9	9	2025-03-05 13:35:37.210722	13000.40	credit	Дивиденды
10	10	2025-03-05 13:35:37.210722	5000.00	debit	Налоговый платеж
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 10, true);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 20, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 10, true);


--
-- Name: entrepreneurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrepreneurs_id_seq', 10, true);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_id_seq', 20, true);


--
-- Name: invoice_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_items_id_seq', 10, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_id_seq', 10, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 10, true);


--
-- Name: purchase_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_items_id_seq', 20, true);


--
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchases_id_seq', 10, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_id_seq', 10, true);


--
-- Name: salaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salaries_id_seq', 10, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 10, true);


--
-- Name: taxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxes_id_seq', 16, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 10, true);


--
-- Name: accounts accounts_account_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_account_number_key UNIQUE (account_number);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: entrepreneurs entrepreneurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrepreneurs
    ADD CONSTRAINT entrepreneurs_pkey PRIMARY KEY (id);


--
-- Name: entrepreneurs entrepreneurs_tax_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrepreneurs
    ADD CONSTRAINT entrepreneurs_tax_id_key UNIQUE (tax_id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: invoice_items invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: purchase_items purchase_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: taxes taxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes
    ADD CONSTRAINT taxes_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: clients clients_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: employees employees_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: expenses expenses_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: invoice_items invoice_items_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON DELETE CASCADE;


--
-- Name: invoices invoices_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: payments payments_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON DELETE CASCADE;


--
-- Name: purchase_items purchase_items_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchases(id) ON DELETE CASCADE;


--
-- Name: purchases purchases_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON DELETE CASCADE;


--
-- Name: reports reports_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: salaries salaries_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- Name: suppliers suppliers_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: taxes taxes_entrepreneur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes
    ADD CONSTRAINT taxes_entrepreneur_id_fkey FOREIGN KEY (entrepreneur_id) REFERENCES public.entrepreneurs(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

