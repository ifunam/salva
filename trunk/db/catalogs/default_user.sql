--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: salva
--
COPY users (id, login, passwd, salt, userstatus_id, email, pkcs7, token, token_expiry, created_on, updated_on) FROM stdin;
1	juan	cd5062247553186a8f03c8aa9ed9c07630570b7c0058bb0b08f712487cc9b878c78c83844fd809317bb597eb71af303981a048aa2ca280ca6424864598f82ae3	RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG	2	alex@bsdcoders.org	\N	\N	\N	2005-11-29 16:29:50	2005-11-29 16:30:09
\.

--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: salva
--
COPY user_groups (id, user_id, group_id, created_on, updated_on) FROM stdin;
1	1	2	2005-11-29 16:29:50	2005-11-29 16:29:50
\.
