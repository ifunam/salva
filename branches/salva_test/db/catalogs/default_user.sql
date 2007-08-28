--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: salva
--
COPY users (login, passwd, salt, userstatus_id, email, pkcs7, token, token_expiry, created_on, updated_on) FROM stdin;
admin	cd5062247553186a8f03c8aa9ed9c07630570b7c0058bb0b08f712487cc9b878c78c83844fd809317bb597eb71af303981a048aa2ca280ca6424864598f82ae3	RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG	2	alex@bsdcoders.org	\N	\N	\N	2005-11-29 16:29:50	2005-11-29 16:30:09
\.
--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: salva
--
COPY users (login, passwd, salt, userstatus_id, email, pkcs7, token, token_expiry, created_on, updated_on) FROM stdin;
juana	cd5062247553186a8f03c8aa9ed9c07630570b7c0058bb0b08f712487cc9b878c78c83844fd809317bb597eb71af303981a048aa2ca280ca6424864598f82ae3	RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG	2	alex@fisica.unam.mx	\N	\N	\N	2005-11-29 16:29:50	2005-11-29 16:30:09
\.
--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: salva
--
COPY users (login, passwd, salt, userstatus_id, email, pkcs7, token, token_expiry, created_on, updated_on) FROM stdin;
panchito	cd5062247553186a8f03c8aa9ed9c07630570b7c0058bb0b08f712487cc9b878c78c83844fd809317bb597eb71af303981a048aa2ca280ca6424864598f82ae3	RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG	2	alexjr85@gmail.com	\N	\N	\N	2005-11-29 16:29:50	2005-11-29 16:30:09
\.
--
-- Data for Name: user_roleingroups; Type: TABLE DATA; Schema: public; Owner: salva
-- Administrador
COPY user_roleingroups (id, user_id, roleingroup_id, created_on, updated_on) FROM stdin;
1	1	1	2005-11-29 16:29:50	2005-11-29 16:29:50
\.
-- Jefe del Departamento
COPY user_roleingroups (id, user_id, roleingroup_id, created_on, updated_on) FROM stdin;
2	2	3	2005-11-29 16:29:50	2005-11-29 16:29:50
\.
-- Miembro del Departamento
COPY user_roleingroups (id, user_id, roleingroup_id, created_on, updated_on) FROM stdin;
3	3	2	2005-11-29 16:29:50	2005-11-29 16:29:50
\.

UPDATE users SET user_incharge_id = 2 WHERE login = 'panchito';
