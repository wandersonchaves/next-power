--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.6 (Homebrew)

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
-- Name: CustomerStatusEnum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."CustomerStatusEnum" AS ENUM (
    'WAITING_LIST',
    'CONFIRMED',
    'CANCELED',
    'INACTIVE',
    'ACTIVE'
);


ALTER TYPE public."CustomerStatusEnum" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    id text NOT NULL,
    "userId" text NOT NULL,
    type text NOT NULL,
    provider text NOT NULL,
    "providerAccountId" text NOT NULL,
    refresh_token text,
    access_token text,
    expires_at integer,
    token_type text,
    scope text,
    id_token text,
    session_state text
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- Name: Carnet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Carnet" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    status text NOT NULL,
    repeats integer NOT NULL,
    value integer NOT NULL,
    cover text NOT NULL,
    link text NOT NULL,
    "carnetLink" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "carnetId" integer NOT NULL,
    "customId" text DEFAULT ''::text,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Carnet" OWNER TO postgres;

--
-- Name: Charge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Charge" (
    id text NOT NULL,
    "carnetId" text NOT NULL,
    status text NOT NULL,
    url text NOT NULL,
    parcel integer NOT NULL,
    value integer NOT NULL,
    "expireAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "chargeId" integer NOT NULL,
    "parcelLink" text DEFAULT ''::text,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Charge" OWNER TO postgres;

--
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer" (
    id text NOT NULL,
    name text NOT NULL,
    cpf text NOT NULL,
    "birthDate" timestamp(3) without time zone,
    phone text,
    email text,
    address text,
    "postalCode" text,
    "spouseName" text,
    "carnetGenerated" boolean DEFAULT false NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."CustomerStatusEnum" DEFAULT 'WAITING_LIST'::public."CustomerStatusEnum" NOT NULL
);


ALTER TABLE public."Customer" OWNER TO postgres;

--
-- Name: Session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Session" (
    id text NOT NULL,
    "sessionToken" text NOT NULL,
    "userId" text NOT NULL,
    expires timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Session" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text,
    email text,
    "emailVerified" timestamp(3) without time zone,
    image text,
    "isActive" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: VerificationToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VerificationToken" (
    identifier text NOT NULL,
    token text NOT NULL,
    expires timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."VerificationToken" OWNER TO postgres;

--
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" (id, "userId", type, provider, "providerAccountId", refresh_token, access_token, expires_at, token_type, scope, id_token, session_state) FROM stdin;
cm4c0pjbk0002r10fbyeorf23	cm4c0pjb70000r10f75nd7pcf	oauth	google	100005014861206741998	\N	ya29.a0AeDClZBVc81WaVl6kD3YjfqcZuePdcejzVp3NyJjMlRBNaIwwX7Pc-MF2pS4iuJ4TSNJv7NqwFv03K0kLWuKbPJnzzsRi5rG-_atBvrBIOVt2EnjDuO6WSmLsHwnrc1hKOrn-_YeX5Ag8HJZGIVK9v4IvzapBIXME3RVan_aaCgYKAfcSARASFQHGX2MiLHfiD3VFBxkRejz_vbKWug0175	1733449123	Bearer	https://www.googleapis.com/auth/userinfo.email openid https://www.googleapis.com/auth/userinfo.profile	eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOGEyMGFmN2ZjOThmOTdmNDRiMTQyYjRkNWQwODg0ZWIwOTM3YzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAwMDA1MDE0ODYxMjA2NzQxOTk4IiwiZW1haWwiOiJqb3NhZGVja3NvYXJlc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6InVYNWt4NEwtYzVSTWxQZjJ5RmhlWEEiLCJuYW1lIjoiSm9zYWRlY2sgU29hcmVzIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0t0WVhOM0U1d2ktUUNycEZtb3hRa1U5T1RBMXlyY0R5eTNsUE1QWUZVa3kzM2VwQmJHNWc9czk2LWMiLCJnaXZlbl9uYW1lIjoiSm9zYWRlY2siLCJmYW1pbHlfbmFtZSI6IlNvYXJlcyIsImlhdCI6MTczMzQ0NTUyNCwiZXhwIjoxNzMzNDQ5MTI0fQ.a3MSb9e1T_dmTTcxkv9yjb1bwA0MlWUS1jm14yHF_0Z7NtwhWnHoqHJepQLReQZ5zOrY2o9SZE9bjqtKQNnRd_2l4Hk780lmtFms3jbqkDOAHcvd-TjP3Cnudklr5AUMOqEZ1d2xB1ogDKbx43OQ6SP9sL1PW-eAxF72Y3rSyVQ5RScAYmEUi_M0hDPtCHSkf-nflSN6HqNH8vlsInjvUNaNrC_j1jtFO76XC_AQcYwlJCPdl7EKallegUfoNCxrLOewQbq-41ivmanfziU8HJaH5REikPlW8OtOMG0qoZlF6G74eDvmQhNRG_c-Hg-FttkLWuxtAGWMOiTMUSG22w	\N
cm4c28jst0002o70fzzj8kbj8	cm4c28jsn0000o70flh28vukl	oauth	google	116656930019896240564	\N	ya29.a0AeDClZB3pGEeUvClUpVjj5IIJUBmc5EcxwGws-7OT55FItU1WVP8tv_OPZCa6fcViNXTnvRV2fq8rZyHho8of0rk1Bc8KxYcMTDILoh8Soy8_GPpWhlN-WNvGxuUvZ0E7QU7-LIOhEcMaIi4epgNwN1LzuQ-okMo0FwaCgYKASQSAQ4SFQHGX2Mikcq11pQyoOmJEm4gqyrzOg0170	1733451690	Bearer	https://www.googleapis.com/auth/userinfo.email openid https://www.googleapis.com/auth/userinfo.profile	eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOGEyMGFmN2ZjOThmOTdmNDRiMTQyYjRkNWQwODg0ZWIwOTM3YzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE2NjU2OTMwMDE5ODk2MjQwNTY0IiwiZW1haWwiOiJ3YW5kZXJzb25jaGF2ZXNicjE0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWW5ackxZLVpyTjNOTUwxMjIxSE9FUSIsIm5hbWUiOiJXYW5kZXJzb24gQ2hhdmVzIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tMbWg5enk2eWV0SmxrMHNPTkkwbFNVSlgyVDhpUjN3cHlGOWljdi1zdmFYd2ViUT1zOTYtYyIsImdpdmVuX25hbWUiOiJXYW5kZXJzb24iLCJmYW1pbHlfbmFtZSI6IkNoYXZlcyIsImlhdCI6MTczMzQ0ODA5MSwiZXhwIjoxNzMzNDUxNjkxfQ.po-nZ8qH6BdfmoOYAiFAo5XgSi7fDsieEr3v3Ial3QlO9ByrzcpSH_-JHNJcsts7J2D89vrgWrfQ8ysLLSKOQzkrqaFJz2JrU_tIzP5ue2JIRiAm5Z12MfyBu82pzqxnBAhB9icwF5aiDWasntt0c1pOci363P9hYxkXcOvsui7ztrT3wGqgbZslAw4UDLHQHY0hCVIIj_H1dSAmz2-NwDSOcH-B9_R0XIUXxkGggGb0OdnpiHSOIHxin4kGqSUJoSky_brzP1QjT_ap1yLWChYtFMN6cFtgxphShmbJMcWAVjqpTHXmRc1nsPntqTVRKGYKWY8IIYpZJ5F6TIs1Cg	\N
cm4fzg0aq007en10fque9srt4	cm4fzg0al007cn10fpyjxb6xn	oauth	google	103484731498896944019	\N	ya29.a0AeDClZB7WeBms4vjjsEw_JOnSyYiYLdSbp-5Hz04kGfxOYYtw87G7fIEGqW7ssahxqAzD5s4saYSPKcWLoIwkDLk4M0jL6oAr-c973gYqmjH9zx6AdT2MX-FqRwJJdi_NBpK-19SDIyRAqmLx8hS7RKtwgx5IAYQy6OmQ67paCgYKAT4SARMSFQHGX2Mi6cZ9ehWrtVWNSun8JkO8Tg0175	1733688864	Bearer	https://www.googleapis.com/auth/userinfo.email openid https://www.googleapis.com/auth/userinfo.profile	eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOGEyMGFmN2ZjOThmOTdmNDRiMTQyYjRkNWQwODg0ZWIwOTM3YzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAzNDg0NzMxNDk4ODk2OTQ0MDE5IiwiZW1haWwiOiJnZXNzeWNhLmZlcm5hbmRlczg5QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUmI4QnU4bWNQdTE4bHJQeGdGOWsxZyIsIm5hbWUiOiJHZXNzeWNhIEZlcm5hbmRlcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NMbUtWNlpGWTZfaDFGWkkxczkxYTdyNm53YlZMSkhIZ2NKYWx4b01tMFhzTGFWdDhDRWRnPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6Ikdlc3N5Y2EiLCJmYW1pbHlfbmFtZSI6IkZlcm5hbmRlcyIsImlhdCI6MTczMzY4NTI2NSwiZXhwIjoxNzMzNjg4ODY1fQ.jEcVFCOGrC8MZpx1l073eDcDf1E3Tm0GqMMqdZDDc72WCWvrhEWSLisGVR7xlk4cB5RGUjWGXtcm5LZ5z3b0GhZf5BLidKzcYuqGvu4CDHUEoMAwpAIK_eDeHJmsFFVAB6oFsYDp3Ihn84qut4yEOlscd29w4j2OuZkkugvLKAkZvAqbxxqFJIx-FQALTbdX3njmLfvvLpqE-QtfQGQAGxG6Jf3QQrTRHa_b-eml-vyYV7gY88rOXGeRP7ztFLKRs2b93RDOcq6qT18URp8ihCLpMZ8E6b_8CefTIfN_qbjeKRiPth6MK7S9-GGduXo0Do3GTNnNKtMdBg4gAheZ6A	\N
cm4g69wrb00qhn10fv6pt89hc	cm4g69wr000qfn10fx31pc2in	oauth	google	104532136628492017705	\N	ya29.a0AeDClZDnNoGFpYEVCaiHNCAcn5-lNCT5I24xbHfI0d3HTdMan9gUunOcv9Ow5IHY0lQ7_aqfoZeGXQQiOI573EAGqMZiFTcuhPQSkUZORxGhRUtHAjKUa-vtJrmPGplFLGWuskUf2IpkUvBpP6ftPgrz21Lwx9YqeU4sJNnzaCgYKAdISARASFQHGX2MiKCjrBYuIKs69NDXwsxt33w0175	1733700337	Bearer	https://www.googleapis.com/auth/userinfo.profile openid https://www.googleapis.com/auth/userinfo.email	eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOGEyMGFmN2ZjOThmOTdmNDRiMTQyYjRkNWQwODg0ZWIwOTM3YzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA0NTMyMTM2NjI4NDkyMDE3NzA1IiwiZW1haWwiOiJhbmRlcnNvbnNvYXJlc2RldkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6Im9Od2cyZlBheW9TOXpvUlFXVXNVOXciLCJuYW1lIjoiQW5kZXJzb24gU29hcmVzIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tWTlFwQklXS3YwWDdDejZjMFVtVDB2eDA0MEI0bmhTdVJyUlpUUEVHZ2JETGtyMFRLPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkFuZGVyc29uIiwiZmFtaWx5X25hbWUiOiJTb2FyZXMiLCJpYXQiOjE3MzM2OTY3MzgsImV4cCI6MTczMzcwMDMzOH0.OnDWpjN45rRDTN0t9Tmdpo4GJavNB85SGqeH8aS12bMssjmw2yfVF63EAL3HVybAB29u3yTpWvJcB6DqAsGVBPvbETigsrVKphNfliU0mBV9ta0mx4V-So3zKU84E69w6Wfw1zTonmQj-QCo46X7j4Wvs2xRLvPzk5ItWovX2JMgWlKHR3FDj1kGsNcYAkXicjytsVlTeKNYcgJdOTeuw7x2zC31cAPisjJW7eOvKzYK63rVY4cIeCQ81Xb4sdFeiLWOkEPrYn78vUpY17Pef3esjYNhiAuZVNYOtqqNPnqe5BhSn_bhCrVs56cZtMfE1tqRQxWrVpJYlVFhGXydoQ	\N
cm4g6bh5o00qmn10fqmmy11hr	cm4g6bh4n00qkn10fpcgql761	oauth	google	108409615865747924488	\N	ya29.a0AeDClZDll_jrClttw67oboBusEd3pLSKMw2gjnGLvoMqiTo_84LUzGdX9p1Z_nqVokp7vR_KAve4vwWmzDvOw0FQ8fbY8aKs0cu4Dk1LK1edroT-U0NypmZk4_JnH1GomNJaWDnTIovo5rXwQnG9m_dZsLOKsU8NeLoCcDu_aCgYKAb0SARMSFQHGX2MiIxgFTIGZJ8L57wB4PiPdRw0175	1733700410	Bearer	https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email openid	eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOGEyMGFmN2ZjOThmOTdmNDRiMTQyYjRkNWQwODg0ZWIwOTM3YzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA4NDA5NjE1ODY1NzQ3OTI0NDg4IiwiZW1haWwiOiJqb2Nhc3RyYWxpbWFwYXpAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiIteXluR0RQTXBtVkZBMUw5UnBINlhBIiwibmFtZSI6IkpvY2FzdHJhIExpbWEgUGF6IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0lXN0JCSVVfVmNiTzZDR3ZRRkVnRHNvNTZLWHRKdU1OeGt0dWFib3czVEdWa1pxMVgtPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkpvY2FzdHJhIiwiZmFtaWx5X25hbWUiOiJMaW1hIFBheiIsImlhdCI6MTczMzY5NjgxMSwiZXhwIjoxNzMzNzAwNDExfQ.BBn4GLiXyLLz_6TgTFTNprbvNCZBUqKQ3GNQ8M7yHnwcdAe8J1r2tnnRk_sZ8mX5dmLnrV_R-J9Qimzo3RjMsTVHTXSLIVoGZL9kyv2ZyX41_0ZcM3i0vbwyY-ojN-wWSEJd24MfClSALFAx4nJCgS3FBsKsJSToA957P2FUn62iTC4BOMIq46n3ZNCMkagZxsuQe1eFveeU7Ie16HCtRQEgj_V_ygfs9GqerrCGl60vlcBGQazJwHH9h0laIpX9O_smX7Z_zxhJNZQCDm1DlLmFLHWOcG6mUvTVjS5woj41sect5fI4YpaizeYRnjCIBP9a3DK8d_FMPf5z3uPS_Q	\N
cm4o93tk5000qmy0f303uctio	cm4o93tik000omy0f0phergx0	oauth	google	101767944370444735240	\N	ya29.a0ARW5m76WQyE4IZ1gzne0HW3Gus4eGzXiGyP2kxitVC5I7XtZW8QWlvtXvVN71DbhNbQ5UA4Wuq5Bn8F0zFB-B8DZp1aPVSvfz4HaooPjSgdvjLE-j2JT-ys7AkTvojRaImkfGKN9BikB-JF0Fs8E4Oa3gIo-CmkUKwaCgYKAaUSARASFQHGX2Mi3j-tsXaCBp2LXxFK7gccEA0169	1734188820	Bearer	https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid	eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2NGZlYWNlYzNlYmRmYWE3MzExYjlkOGU3M2M0MjgxOGYyOTEyNjQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAxNzY3OTQ0MzcwNDQ0NzM1MjQwIiwiZW1haWwiOiJ3YW5kZXJzb25zY3BpYnJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJ0clBqcW9IYzJPcG40N3U4SllRbVJnIiwibmFtZSI6IldhbmRlcnNvbiBDaGF2ZXMiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSlVUcUhFY3pNWmcwRC1TNm1hdWZaRUN6bjhHZURESHhnVnV6UUFtZG9VUGo4MjBYQW56UT1zOTYtYyIsImdpdmVuX25hbWUiOiJXYW5kZXJzb24iLCJmYW1pbHlfbmFtZSI6IkNoYXZlcyIsImlhdCI6MTczNDE4NTIyMiwiZXhwIjoxNzM0MTg4ODIyfQ.Ikwz6NxKG25dyEPr2N9EmTnkrLB0TqCXhiFqGfcUh0YIL2o3Jl3tOKljfm6lMqmglO8dP8z7E7pOVnv5FGld-RUW9i17ZJ8vq7GebwIUYsqGowCLsHT0BBS1e1af4zKymX0fBdAAtmjzeDYNnrfBa6_N-poeaKD0Hwtjs-2u7wvBofAgCkHhYkdPTfCGPjSOAcopYSLmdf6fya3Go1qUESHGSJtw-0UuRpQr8Lot_kRq0zcD7-RvIvXHgCSIWtCySnGeXqem_N1b2Z3415L9xpNrE7CK4rCQhUGpg95oyYlIwS-Q7GjNPP5o1tY6puTe8d8IXnxb6a4Y-tvhu8DCaw	\N
cm4vyjiln000vmy0fnto27230	cm4vyjikf000tmy0fryvwvrn2	oauth	google	107282756527414852339	\N	ya29.a0ARW5m76uqL-LlmfnKjprdE_P0aGDNxaq7kK7vw_1aMkeMbEz4-YeB6xDgDJtsiLfbG1MMTej-_boUJP1Jtmhiz5o65MPFDmEaWl1FhbM813T7XTqPF8ixGoe6aMlQzuiLYE0Fy4o6LW4-1eVRD9RK4c0Mtq6xjFO9OWP1gVqaCgYKAbMSARESFQHGX2MilmhkzsXfGk0f9MnsU-UhdA0175	1734654807	Bearer	openid https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email	eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2NGZlYWNlYzNlYmRmYWE3MzExYjlkOGU3M2M0MjgxOGYyOTEyNjQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NDE4NTcyOTI4MS1ucHNtcjg2ODZ2OG5sYW1yMmV1ZmYycDhuaHExbDQwbS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijk0MTg1NzI5MjgxLW5wc21yODY4NnY4bmxhbXIyZXVmZjJwOG5ocTFsNDBtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA3MjgyNzU2NTI3NDE0ODUyMzM5IiwiZW1haWwiOiJpYWxseWdzb2FyZXNAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiI2cWMtWV9BNHJGa2hZN0xCOEt5YU13IiwibmFtZSI6IklhbGx5IFNvYXJlcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NJYS1VMzk5ejlPRm9GNmoxRWF5ZG1vZWZsRUd1Qk4xaHN0MXQ3Nzk1LVgzaThFNlE0PXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IklhbGx5IiwiZmFtaWx5X25hbWUiOiJTb2FyZXMiLCJpYXQiOjE3MzQ2NTEyMDgsImV4cCI6MTczNDY1NDgwOH0.I68pyTrWuteyWrr_RhVnbMF9LbZ5mzxRtBA2zr_JoxNq0xeOCAKqPyhM6UKwkCThDecVxJUN7uFVNFkAoOO06aRjW3wxi8b5Eq17BHT8QpTm2fLSRCOOb6QF4K6mmpDHzW82aaSgP05zMwfulYYItkipLE2ArFhXC23sxpD31OxPoO97mCncs6MqCATd3DaPlh5Fvabc-VQOjiUfKY_BAI2_gbSCIAx6NK9MDXy_6aJzbnEB1Cxbe63t8lUXLgErMf2_w6KgT20FP-d6NPYB-68dhL37ADq6yXOEHUU3sNxVRnAxUiFAQF4cPKOPTAhMXhleHuiOIAbJY4Bi4P6mKg	\N
\.


--
-- Data for Name: Carnet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Carnet" (id, "customerId", status, repeats, value, cover, link, "carnetLink", "createdAt", "carnetId", "customId", "updatedAt") FROM stdin;
cm4g0jfsk00omn10f2tfjycon	cm4cvtykw004io70f7so7gzyk	up_to_date	0	0	https://download.gerencianet.com.br/275362_449_NEMPA1/275362-3481-LACA1-capa.pdf	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1	#	2024-12-08 19:45:05.168	49323103	\N	2024-12-20 18:55:37.914
cm4g0jl7q00p8n10fyn308bxz	cm4cvtyks004go70f2jyrigmz	up_to_date	0	0	https://download.gerencianet.com.br/275362_450_DRALEO2/275362-3490-TABRA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0	#	2024-12-08 19:45:12.199	49323104	\N	2024-12-20 18:55:37.914
cm4g0joqz00pun10fhs8ekokv	cm4cvtykl004eo70fymza352v	up_to_date	0	0	https://download.gerencianet.com.br/275362_451_LOMA0/275362-3499-RAADO1-capa.pdf	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1	#	2024-12-08 19:45:16.806	49323107	\N	2024-12-20 18:55:37.914
cm4g7xye000r4n10fvtr9g8m4	cm4g7dun300r1n10f5x1qngxx	up_to_date	0	0	https://download.gerencianet.com.br/275362_452_MALLO3/275362-3508-BOLEO2-capa.pdf	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2	#	2024-12-08 23:12:19.767	49323629	\N	2024-12-20 18:55:37.914
cm4k688b10001my0f1yzql4pc	cm4cvtys4008ao70fye8s39m4	up_to_date	0	0	https://download.gerencianet.com.br/275362_453_SILUA3/275362-3517-RRALO9-capa.pdf	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9	#	2024-12-11 17:35:24.674	49448174	\N	2024-12-20 18:55:37.914
cm4fuqoa70001pb0fn2qsr32l	cm4cvtysj008ko70fbdzenihw	up_to_date	0	0	https://download.gerencianet.com.br/275362_384_MALDRA8/275362-2896-ENALE8-capa.pdf	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8	#	2024-12-08 17:02:45.001	49322206	\N	2024-12-20 18:55:37.914
cm4furg4h000npb0ff4mofm08	cm4cvtysd008go70fd728f0o7	up_to_date	0	0	https://download.gerencianet.com.br/275362_385_DRONEM0/275362-2905-BORRA6-capa.pdf	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6	#	2024-12-08 17:03:21.144	49322209	\N	2024-12-20 18:55:37.914
cm4d6n5dz0001lo0f9e9uim5g	cm4cvtyr6007qo70fse61p3yb	up_to_date	0	0	https://download.gerencianet.com.br/275362_381_SIENA8/275362-2869-CHOLEO4-capa.pdf	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4	#	2024-12-06 20:12:37.502	49297477	\N	2024-12-20 18:55:37.914
cm4d6p2yn000nlo0fl92kee0p	cm4cvtysg008io70f5unnqned	up_to_date	0	0	https://download.gerencianet.com.br/275362_382_CHODRA4/275362-2878-XILA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0	#	2024-12-06 20:14:07.674	49297563	\N	2024-12-20 18:55:37.914
cm4d6slna0019lo0fn4t3kzoz	cm4cvtymn004yo70f0wpin22t	up_to_date	0	0	https://download.gerencianet.com.br/275362_383_NEMDA3/275362-2887-LOMEH7-capa.pdf	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7	#	2024-12-06 20:16:51.854	49297671	\N	2024-12-20 18:55:37.914
cm4furl0u0019pb0f0l51eerb	cm4cvtys9008eo70fuciq905u	up_to_date	0	0	https://download.gerencianet.com.br/275362_386_BRACA5/275362-2914-TAPA4-capa.pdf	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4	#	2024-12-08 17:03:27.529	49322211	\N	2024-12-20 18:55:37.914
cm4furp83001vpb0fxv1evbsp	cm4cvtys7008co70f9g7jifkm	up_to_date	0	0	https://download.gerencianet.com.br/275362_387_SERBRA1/275362-2923-MEHCA1-capa.pdf	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1	#	2024-12-08 17:03:32.975	49322212	\N	2024-12-20 18:55:37.914
cm4fus75m002hpb0fy0abatkd	cm4cvtys10088o70felznlz1c	up_to_date	0	0	https://download.gerencianet.com.br/275362_388_CATA4/275362-2932-BRAMEH6-capa.pdf	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6	#	2024-12-08 17:03:56.198	49322215	\N	2024-12-20 18:55:37.914
cm4fuufie0033pb0fg3x86l4n	cm4cvtyry0086o70fj0mqoafc	up_to_date	0	0	https://download.gerencianet.com.br/275362_389_BRADRO2/275362-2941-RAARAA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7	#	2024-12-08 17:05:40.318	49322226	\N	2024-12-20 18:55:37.914
cm4fuukqq003ppb0f7g2lavsr	cm4cvtyru0084o70fcvdp44xk	up_to_date	0	0	https://download.gerencianet.com.br/275362_390_NAEDO0/275362-2950-LEOHI1-capa.pdf	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1	#	2024-12-08 17:05:47.131	49322227	\N	2024-12-20 18:55:37.914
cm4fuupbv004bpb0fx8m6tk3t	cm4cvtyrr0082o70f7akivflf	up_to_date	0	0	https://download.gerencianet.com.br/275362_391_DROMAL2/275362-2959-BRAMAL3-capa.pdf	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3	#	2024-12-08 17:05:53.066	49322228	\N	2024-12-20 18:55:37.914
cm4fuvo9q004xpb0fv1qia8w1	cm4cvtyrn0080o70f8zrh9mp9	up_to_date	0	0	https://download.gerencianet.com.br/275362_392_CACA7/275362-2968-MACOR4-capa.pdf	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4	#	2024-12-08 17:06:38.335	49322231	\N	2024-12-20 18:55:37.914
cm4fuvs95005jpb0fw4c0mnuk	cm4cvtyrk007yo70fplqapiv8	up_to_date	0	0	https://download.gerencianet.com.br/275362_393_SERDO7/275362-2977-CACHO1-capa.pdf	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1	#	2024-12-08 17:06:43.525	49322232	\N	2024-12-20 18:55:37.914
cm4fuvvlw0065pb0f61hxbiep	cm4cvtyrh007wo70frz9vevc0	up_to_date	0	0	https://download.gerencianet.com.br/275362_394_CASER2/275362-2986-DALEO5-capa.pdf	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5	#	2024-12-08 17:06:47.869	49322234	\N	2024-12-20 18:55:37.914
cm4fuvz2w006rpb0f5qgtr8fh	cm4cvtyrd007uo70f8oxzjev6	up_to_date	0	0	https://download.gerencianet.com.br/275362_395_NAEXI3/275362-2995-NEMSER6-capa.pdf	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6	#	2024-12-08 17:06:52.351	49322236	\N	2024-12-20 18:55:37.914
cm4fuw41c007dpb0fjq6ew3fs	cm4cvtyr9007so70fo0nd25km	up_to_date	0	0	https://download.gerencianet.com.br/275362_396_LEHI4/275362-3004-XICOR8-capa.pdf	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8	#	2024-12-08 17:06:58.795	49322237	\N	2024-12-20 18:55:37.914
cm4fuwb30007zpb0fa1v07imh	cm4cvtyr3007oo70fo04ixxbd	up_to_date	0	0	https://download.gerencianet.com.br/275362_397_CALE6/275362-3013-BRALUA2-capa.pdf	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2	#	2024-12-08 17:07:07.927	49322239	\N	2024-12-20 18:55:37.914
cm4fuwg7q008lpb0fbpbyyy64	cm4cvtyr0007mo70f9nq67efx	up_to_date	0	0	https://download.gerencianet.com.br/275362_398_NEMRAA0/275362-3022-MALDA2-capa.pdf	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2	#	2024-12-08 17:07:14.578	49322240	\N	2024-12-20 18:55:37.914
cm4fuwjsk0097pb0f0pc2g5ie	cm4cvtyqx007ko70fq44jfhe7	up_to_date	0	0	https://download.gerencianet.com.br/275362_399_ENANEM8/275362-3031-RAADRO8-capa.pdf	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8	#	2024-12-08 17:07:19.211	49322241	\N	2024-12-20 18:55:37.914
cm4fuwnjf009tpb0fy3kc1gj0	cm4cvtyqu007io70fwexe3oxm	up_to_date	0	0	https://download.gerencianet.com.br/275362_400_DROLEO3/275362-3040-LEOPA4-capa.pdf	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4	#	2024-12-08 17:07:24.055	49322242	\N	2024-12-20 18:55:37.914
cm4fwi5bi00afpb0faqjmc5bs	cm4cvtyqn007eo70fol7zvccn	up_to_date	0	0	https://download.gerencianet.com.br/275362_401_DODO5/275362-3049-LESI9-capa.pdf	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9	#	2024-12-08 17:52:06.503	49322503	\N	2024-12-20 18:55:37.914
cm4fwi9am00b1pb0fihzi6vy8	cm4cvtyqk007co70f6gbykqhg	up_to_date	0	0	https://download.gerencianet.com.br/275362_402_DONAE3/275362-3058-CORMEH1-capa.pdf	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1	#	2024-12-08 17:52:11.657	49322506	\N	2024-12-20 18:55:37.914
cm4fwidao00bnpb0fzp86kely	cm4cvtyqh007ao70fo84qfzfd	up_to_date	0	0	https://download.gerencianet.com.br/275362_403_BOCA6/275362-3067-XIZE9-capa.pdf	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9	#	2024-12-08 17:52:16.843	49322508	\N	2024-12-20 18:55:37.914
cm4fwih1n00c9pb0ffv3224ua	cm4cvtyqe0078o70ft6z9r18y	up_to_date	0	0	https://download.gerencianet.com.br/275362_404_DRALA3/275362-3076-HINEM3-capa.pdf	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3	#	2024-12-08 17:52:21.703	49322511	\N	2024-12-20 18:55:37.914
cm4fwimk400cvpb0f8tpaoobn	cm4cvtyqb0076o70fng23gq5f	up_to_date	0	0	https://download.gerencianet.com.br/275362_405_CADRA7/275362-3085-BRASER4-capa.pdf	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4	#	2024-12-08 17:52:28.848	49322512	\N	2024-12-20 18:55:37.914
cm4fwiq7s00dhpb0f9j2tf41q	cm4cvtyq80074o70fzu6weqmf	up_to_date	0	0	https://download.gerencianet.com.br/275362_406_LEFO1/275362-3094-CHOBO0-capa.pdf	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0	#	2024-12-08 17:52:33.586	49322513	\N	2024-12-20 18:55:37.914
cm4fwitsx00e3pb0fjh7ngskl	cm4cvtyq50072o70fnxhe6isu	up_to_date	0	0	https://download.gerencianet.com.br/275362_407_RRASI4/275362-3103-LAFO3-capa.pdf	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3	#	2024-12-08 17:52:38.229	49322514	\N	2024-12-20 18:55:37.914
cm4fwixfp00eppb0fqeh3vedu	cm4cvtyq10070o70fcutji2vx	up_to_date	0	0	https://download.gerencianet.com.br/275362_408_SIXI2/275362-3112-TATA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0	#	2024-12-08 17:52:42.946	49322515	\N	2024-12-20 18:55:37.914
cm4fwsfv40001n10fariup7xm	cm4cvtypy006yo70f25u1ss1v	up_to_date	0	0	https://download.gerencianet.com.br/275362_409_PATA0/275362-3121-CALEO4-capa.pdf	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4	#	2024-12-08 18:00:06.726	49322569	\N	2024-12-20 18:55:37.914
cm4fwsl1a000nn10flec0b3qz	cm4cvtypv006wo70f8mybl6tl	up_to_date	0	0	https://download.gerencianet.com.br/275362_410_SICOR4/275362-3130-MABRA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7	#	2024-12-08 18:00:13.432	49322571	\N	2024-12-20 18:55:37.914
cm4fwsqpl0019n10fc1r2pgm9	cm4cvtypr006uo70f8iegzpz4	up_to_date	0	0	https://download.gerencianet.com.br/275362_411_LODA5/275362-3139-LAMA4-capa.pdf	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4	#	2024-12-08 18:00:20.788	49322574	\N	2024-12-20 18:55:37.914
cm4fwsuwp001vn10flnmxrxgd	cm4cvtypp006so70f6bbuxzgv	up_to_date	0	0	https://download.gerencianet.com.br/275362_412_LEBO2/275362-3148-DRODO8-capa.pdf	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8	#	2024-12-08 18:00:26.174	49322575	\N	2024-12-20 18:55:37.914
cm4fyz3l1002hn10f1sk915m1	cm4cvtypl006qo70fly5toiid	up_to_date	0	0	https://download.gerencianet.com.br/275362_413_BORRA9/275362-3157-CORDO1-capa.pdf	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1	#	2024-12-08 19:01:16.636	49322974	\N	2024-12-20 18:55:37.914
cm4fyz8h20033n10fvywmos9p	cm4cvtypi006oo70fhhnfg07r	up_to_date	0	0	https://download.gerencianet.com.br/275362_414_CORCOR7/275362-3166-ZEHI2-capa.pdf	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2	#	2024-12-08 19:01:22.976	49322975	\N	2024-12-20 18:55:37.914
cm4fyzckp003pn10fwrltk79q	cm4cvtype006mo70fq9eia0sb	up_to_date	0	0	https://download.gerencianet.com.br/275362_415_DOMAL1/275362-3175-TACA2-capa.pdf	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2	#	2024-12-08 19:01:28.281	49322978	\N	2024-12-20 18:55:37.914
cm4fyzgix004bn10feswpl3g3	cm4cvtypc006ko70f5s1rjz2w	up_to_date	0	0	https://download.gerencianet.com.br/275362_416_LEOENA6/275362-3184-CHOZE4-capa.pdf	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4	#	2024-12-08 19:01:33.386	49322979	\N	2024-12-20 18:55:37.914
cm4fyzk4v004xn10fahxrtyqh	cm4cvtyp8006io70f9mcycv8w	up_to_date	0	0	https://download.gerencianet.com.br/275362_417_NEMMAL4/275362-3193-MALBO3-capa.pdf	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3	#	2024-12-08 19:01:38.07	49322980	\N	2024-12-20 18:55:37.914
cm4fyzo62005jn10fgpvsjpql	cm4cvtyp5006go70f71apq0wb	up_to_date	0	0	https://download.gerencianet.com.br/275362_418_CASI8/275362-3202-XIBO8-capa.pdf	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8	#	2024-12-08 19:01:43.316	49322981	\N	2024-12-20 18:55:37.914
cm4fyzrwl0065n10feb09kp2d	cm4cvtyp2006eo70ftygr49d9	up_to_date	0	0	https://download.gerencianet.com.br/275362_419_MEHRRA6/275362-3211-LEBRA6-capa.pdf	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6	#	2024-12-08 19:01:48.14	49322982	\N	2024-12-20 18:55:37.914
cm4fyzvi7006rn10fhxa2v922	cm4cvtyoz006co70fe5vjxony	up_to_date	0	0	https://download.gerencianet.com.br/275362_420_MEHMEH1/275362-3220-SERENA1-capa.pdf	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1	#	2024-12-08 19:01:52.826	49322983	\N	2024-12-20 18:55:37.914
cm4g0eo9t007in10ft5vsopyf	cm4cvtyow006ao70fl2wgfode	up_to_date	0	0	https://download.gerencianet.com.br/275362_421_ENADO9/275362-3229-LAENA9-capa.pdf	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9	#	2024-12-08 19:41:22.905	49323066	\N	2024-12-20 18:55:37.914
cm4g0esi00084n10fl44prmeu	cm4cvtyot0068o70fs84qdzo2	up_to_date	0	0	https://download.gerencianet.com.br/275362_422_RAADA6/275362-3238-RAAFO3-capa.pdf	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3	#	2024-12-08 19:41:28.376	49323067	\N	2024-12-20 18:55:37.914
cm4g0ewmw008qn10fgp1oe3qd	cm4cvtyoq0066o70f2vc0705d	up_to_date	0	0	https://download.gerencianet.com.br/275362_423_NEMRRA9/275362-3247-DRODO8-capa.pdf	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8	#	2024-12-08 19:41:33.747	49323068	\N	2024-12-20 18:55:37.914
cm4g0f083009cn10f0iz5vzur	cm4cvtyon0064o70fb763omb9	up_to_date	0	0	https://download.gerencianet.com.br/275362_424_DAMEH9/275362-3256-TAFO4-capa.pdf	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4	#	2024-12-08 19:41:38.313	49323069	\N	2024-12-20 18:55:37.914
cm4g0f4kp009yn10fycuv4thq	cm4cvtyok0062o70fqa81zigf	up_to_date	0	0	https://download.gerencianet.com.br/275362_425_TAFO0/275362-3265-DARAA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0	#	2024-12-08 19:41:44.028	49323070	\N	2024-12-20 18:55:37.914
cm4g0fah200akn10fi3je7kjp	cm4cvtyog0060o70f0494okjo	up_to_date	0	0	https://download.gerencianet.com.br/275362_426_SIBRA3/275362-3274-CHOENA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0	#	2024-12-08 19:41:51.68	49323071	\N	2024-12-20 18:55:37.914
cm4g0fe4f00b6n10f15fl1d0u	cm4cvtyod005yo70f2dz7ovws	up_to_date	0	0	https://download.gerencianet.com.br/275362_427_MALNEM7/275362-3283-CORXI0-capa.pdf	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0	#	2024-12-08 19:41:56.358	49323072	\N	2024-12-20 18:55:37.914
cm4g0fhfn00bsn10f2d9lfx1n	cm4cvtyo9005wo70fwo05eg27	up_to_date	0	0	https://download.gerencianet.com.br/275362_428_CALA8/275362-3292-ENALUA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0	#	2024-12-08 19:42:00.701	49323073	\N	2024-12-20 18:55:37.914
cm4g0fkz200cen10fo46earwg	cm4cvtyo6005uo70fy2i9cu8a	up_to_date	0	0	https://download.gerencianet.com.br/275362_429_SERTA0/275362-3301-NEMXI2-capa.pdf	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2	#	2024-12-08 19:42:05.235	49323074	\N	2024-12-20 18:55:37.914
cm4g0fokg00d0n10fxjald70k	cm4cvtyo2005so70fwgippmvn	up_to_date	0	0	https://download.gerencianet.com.br/275362_430_NAERRA7/275362-3310-LOCA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7	#	2024-12-08 19:42:09.946	49323075	\N	2024-12-20 18:55:37.914
cm4g0fy1000dmn10f9k91pi25	cm4cvtynz005qo70f98frzmsm	up_to_date	0	0	https://download.gerencianet.com.br/275362_431_CORLE7/275362-3319-MEHXI5-capa.pdf	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5	#	2024-12-08 19:42:22.186	49323076	\N	2024-12-20 18:55:37.914
cm4g0g4k800e8n10fcuifr8q5	cm4cvtyns005mo70f9erx8zuv	up_to_date	0	0	https://download.gerencianet.com.br/275362_432_TASER7/275362-3328-SERNEM1-capa.pdf	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1	#	2024-12-08 19:42:30.652	49323078	\N	2024-12-20 18:55:37.914
cm4g0g7tt00eun10fr20gu3ge	cm4cvtynp005ko70ficnqtndz	up_to_date	0	0	https://download.gerencianet.com.br/275362_433_DRALUA0/275362-3337-PAMAL8-capa.pdf	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8	#	2024-12-08 19:42:34.908	49323080	\N	2024-12-20 18:55:37.914
cm4g0gb7800fgn10fvjl4cv7m	cm4cvtynm005io70f44qfolo7	up_to_date	0	0	https://download.gerencianet.com.br/275362_434_BRAMEH3/275362-3346-SERZE1-capa.pdf	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1	#	2024-12-08 19:42:39.277	49323081	\N	2024-12-20 18:55:37.914
cm4g0ggfi00g2n10fdq9yc3nf	cm4cvtynj005go70fjgp2xesz	up_to_date	0	0	https://download.gerencianet.com.br/275362_435_LUAMEH0/275362-3355-ZEFO0-capa.pdf	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0	#	2024-12-08 19:42:46.042	49323082	\N	2024-12-20 18:55:37.914
cm4g0gkfb00gon10fxzsm7bi9	cm4cvtyng005eo70ffo06be87	up_to_date	0	0	https://download.gerencianet.com.br/275362_436_BRAHI1/275362-3364-TARRA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7	#	2024-12-08 19:42:51.216	49323084	\N	2024-12-20 18:55:37.914
cm4g0go1800han10fxe93ezmv	cm4cvtynd005co70farq0qf3r	up_to_date	0	0	https://download.gerencianet.com.br/275362_437_CORDA2/275362-3373-ZEDRO4-capa.pdf	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4	#	2024-12-08 19:42:55.911	49323085	\N	2024-12-20 18:55:37.914
cm4g0grrw00hwn10f1wdqlw84	cm4cvtyn9005ao70fwqx6tfp1	up_to_date	0	0	https://download.gerencianet.com.br/275362_438_NEMCA6/275362-3382-LARRA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7	#	2024-12-08 19:43:00.748	49323087	\N	2024-12-20 18:55:37.914
cm4g0gvli00iin10fffjb70ae	cm4cvtyn60058o70fxdgc0pby	up_to_date	0	0	https://download.gerencianet.com.br/275362_439_RRADO5/275362-3391-LEZE0-capa.pdf	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0	#	2024-12-08 19:43:05.712	49323089	\N	2024-12-20 18:55:37.914
cm4g0h5bw00j4n10fxsg2oxy2	cm4cvtyn20056o70feiuckp6a	up_to_date	0	0	https://download.gerencianet.com.br/275362_440_PATA1/275362-3400-LASER0-capa.pdf	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0	#	2024-12-08 19:43:18.325	49323091	\N	2024-12-20 18:55:37.914
cm4g0h94v00jqn10f4ki0ju0w	cm4cvtymx0054o70fdcx42t4n	up_to_date	0	0	https://download.gerencianet.com.br/275362_441_CORNEM8/275362-3409-BRACOR0-capa.pdf	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0	#	2024-12-08 19:43:23.211	49323092	\N	2024-12-20 18:55:37.914
cm4g0hd0n00kcn10f9peb1d71	cm4cvtymt0052o70f49x7l7xv	up_to_date	0	0	https://download.gerencianet.com.br/275362_442_RAASI5/275362-3418-LOBRA3-capa.pdf	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3	#	2024-12-08 19:43:28.268	49323093	\N	2024-12-20 18:55:37.914
cm4g0hkch00kyn10feinwoyax	cm4cvtymj004wo70f6c5zwss4	up_to_date	0	0	https://download.gerencianet.com.br/275362_443_CANAE2/275362-3427-DROENA5-capa.pdf	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5	#	2024-12-08 19:43:37.787	49323094	\N	2024-12-20 18:55:37.914
cm4g0ie0g00lkn10f72m3sna7	cm4cvtymd004uo70fkpe6hk94	up_to_date	0	0	https://download.gerencianet.com.br/275362_444_SISER9/275362-3436-BOSI7-capa.pdf	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7	#	2024-12-08 19:44:16.212	49323096	\N	2024-12-20 18:55:37.914
cm4g0ik8y00m6n10fsqs3mm4p	cm4cvtym7004qo70fka8gvuta	up_to_date	0	0	https://download.gerencianet.com.br/275362_445_XIRRA0/275362-3445-LOCA0-capa.pdf	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0	#	2024-12-08 19:44:24.299	49323098	\N	2024-12-20 18:55:37.914
cm4g0iq9000msn10fwidd2955	cm4cvtym2004oo70ffepq8m5f	up_to_date	0	0	https://download.gerencianet.com.br/275362_446_LUASER4/275362-3454-BRALA7-capa.pdf	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7	#	2024-12-08 19:44:32.045	49323099	\N	2024-12-20 18:55:37.914
cm4g0j6xy00nen10f7g7wm92k	cm4cvtylz004mo70fq5d8t8d6	up_to_date	0	0	https://download.gerencianet.com.br/275362_447_CASI6/275362-3463-BORRA4-capa.pdf	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4	#	2024-12-08 19:44:53.73	49323101	\N	2024-12-20 18:55:37.914
cm4g0jau400o0n10f3ixydz7n	cm4cvtylv004ko70fikxbnvlu	up_to_date	0	0	https://download.gerencianet.com.br/275362_448_LUADO7/275362-3472-LOLO3-capa.pdf	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3	#	2024-12-08 19:44:58.775	49323102	\N	2024-12-20 18:55:37.914
\.


--
-- Data for Name: Charge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Charge" (id, "carnetId", status, url, parcel, value, "expireAt", "createdAt", "chargeId", "parcelLink", "updatedAt") FROM stdin;
cm4d6n5dz0002lo0fuoztfgwg	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2869-CHOLEO4	1	25555	2024-12-10 00:00:00	2024-12-06 20:12:37.511	797900939		2024-12-20 18:55:37.917
cm4d6n5dz0003lo0fucdxt6nw	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2870-XISER1	2	25555	2025-01-10 00:00:00	2024-12-06 20:12:37.511	797900940		2024-12-20 18:55:37.917
cm4d6n5dz0004lo0fjqmrh2ep	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2871-BOHI2	3	25555	2025-02-10 00:00:00	2024-12-06 20:12:37.511	797900941		2024-12-20 18:55:37.917
cm4d6n5dz0005lo0fjpeoku5c	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2872-BRAMA6	4	25555	2025-03-10 00:00:00	2024-12-06 20:12:37.511	797900942		2024-12-20 18:55:37.917
cm4d6n5dz0006lo0fh1d8njs4	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2873-BOBRA7	5	25555	2025-04-10 00:00:00	2024-12-06 20:12:37.511	797900943		2024-12-20 18:55:37.917
cm4d6n5dz0007lo0fancp91o7	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2874-MACA4	6	25555	2025-05-10 00:00:00	2024-12-06 20:12:37.511	797900944		2024-12-20 18:55:37.917
cm4d6n5dz0008lo0fotxqqxat	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2875-XILUA0	7	25555	2025-06-10 00:00:00	2024-12-06 20:12:37.511	797900945		2024-12-20 18:55:37.917
cm4d6n5dz0009lo0fdm78fhp5	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2876-XINEM9	8	25555	2025-07-10 00:00:00	2024-12-06 20:12:37.511	797900946		2024-12-20 18:55:37.917
cm4d6n5e0000alo0fqgz1yfou	cm4d6n5dz0001lo0f9e9uim5g	waiting	https://download.gerencianet.com.br/v1/275362_381_SIENA8/275362-2869-CHOLEO4/275362-2877-LUADA3	9	25555	2025-08-10 00:00:00	2024-12-06 20:12:37.511	797900947		2024-12-20 18:55:37.917
cm4d6p2yn000olo0fte3uzx3i	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2878-XILA0	1	25555	2024-12-10 00:00:00	2024-12-06 20:14:07.679	797902238		2024-12-20 18:55:37.917
cm4d6p2yn000plo0f6zzlpxnp	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2879-DOSI4	2	25555	2025-01-10 00:00:00	2024-12-06 20:14:07.679	797902239		2024-12-20 18:55:37.917
cm4d6p2yn000qlo0fdzirigeh	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2880-DOSI7	3	25555	2025-02-10 00:00:00	2024-12-06 20:14:07.679	797902240		2024-12-20 18:55:37.917
cm4d6p2yn000rlo0f7lcef590	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2881-SIDRO6	4	25555	2025-03-10 00:00:00	2024-12-06 20:14:07.679	797902241		2024-12-20 18:55:37.917
cm4d6p2yn000slo0f96ltfplo	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2882-BRACHO3	5	25555	2025-04-10 00:00:00	2024-12-06 20:14:07.679	797902242		2024-12-20 18:55:37.917
cm4d6p2yn000tlo0f54iazlj9	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2883-BRACA4	6	25555	2025-05-10 00:00:00	2024-12-06 20:14:07.679	797902243		2024-12-20 18:55:37.917
cm4d6p2yn000ulo0fmsw5lbk4	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2884-MEHSER9	7	25555	2025-06-10 00:00:00	2024-12-06 20:14:07.679	797902244		2024-12-20 18:55:37.917
cm4d6p2yn000vlo0f9lrw5up4	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2885-MEHSER4	8	25555	2025-07-10 00:00:00	2024-12-06 20:14:07.679	797902245		2024-12-20 18:55:37.917
cm4d6p2yn000wlo0f0k7rmcqe	cm4d6p2yn000nlo0fl92kee0p	waiting	https://download.gerencianet.com.br/v1/275362_382_CHODRA4/275362-2878-XILA0/275362-2886-LEOCOR3	9	25555	2025-08-10 00:00:00	2024-12-06 20:14:07.679	797902246		2024-12-20 18:55:37.917
cm4d6slna001alo0fe79aywux	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2887-LOMEH7	1	25555	2024-12-10 00:00:00	2024-12-06 20:16:51.862	797904220		2024-12-20 18:55:37.917
cm4d6slna001blo0fgdj6tfi7	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2888-LOHI3	2	25555	2025-01-10 00:00:00	2024-12-06 20:16:51.862	797904221		2024-12-20 18:55:37.917
cm4d6slna001clo0fz856bdtu	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2889-LUARAA9	3	25555	2025-02-10 00:00:00	2024-12-06 20:16:51.862	797904222		2024-12-20 18:55:37.917
cm4d6slna001dlo0fnv743hd2	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2890-DADRO4	4	25555	2025-03-10 00:00:00	2024-12-06 20:16:51.862	797904223		2024-12-20 18:55:37.917
cm4d6slna001elo0f7b7pvzhg	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2891-CHOXI3	5	25555	2025-04-10 00:00:00	2024-12-06 20:16:51.862	797904224		2024-12-20 18:55:37.917
cm4d6slna001flo0fuw66nu2z	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2892-BRADRO1	6	25555	2025-05-10 00:00:00	2024-12-06 20:16:51.862	797904225		2024-12-20 18:55:37.917
cm4d6slna001glo0f6t4dryhn	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2893-ENAFO7	7	25555	2025-06-10 00:00:00	2024-12-06 20:16:51.862	797904226		2024-12-20 18:55:37.917
cm4d6slna001hlo0fqpgsgn7d	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2894-CHOPA3	8	25555	2025-07-10 00:00:00	2024-12-06 20:16:51.862	797904227		2024-12-20 18:55:37.917
cm4d6slnb001ilo0fqqmdxce2	cm4d6slna0019lo0fn4t3kzoz	waiting	https://download.gerencianet.com.br/v1/275362_383_NEMDA3/275362-2887-LOMEH7/275362-2895-LECA3	9	25555	2025-08-10 00:00:00	2024-12-06 20:16:51.862	797904228		2024-12-20 18:55:37.917
cm4fuqoa70002pb0f5swwz28b	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2896-ENALE8	1	25555	2024-12-10 00:00:00	2024-12-08 17:02:45.082	798391837		2024-12-20 18:55:37.917
cm4fuqoa70003pb0fvd9oepiy	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2897-NEMRRA9	2	25555	2025-01-10 00:00:00	2024-12-08 17:02:45.082	798391838		2024-12-20 18:55:37.917
cm4fuqoa70004pb0f4j86ojb4	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2898-ZEMA0	3	25555	2025-02-10 00:00:00	2024-12-08 17:02:45.082	798391839		2024-12-20 18:55:37.917
cm4fuqoa70005pb0fip1qayd1	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2899-CADRA5	4	25555	2025-03-10 00:00:00	2024-12-08 17:02:45.082	798391840		2024-12-20 18:55:37.917
cm4fuqoa70006pb0fyz66j0hr	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2900-CABO5	5	25555	2025-04-10 00:00:00	2024-12-08 17:02:45.082	798391841		2024-12-20 18:55:37.917
cm4fuqoa70007pb0fauab6a3q	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2901-LOTA2	6	25555	2025-05-10 00:00:00	2024-12-08 17:02:45.082	798391842		2024-12-20 18:55:37.917
cm4fuqoa70008pb0fst8vaqzs	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2902-PASER8	7	25555	2025-06-10 00:00:00	2024-12-08 17:02:45.082	798391843		2024-12-20 18:55:37.917
cm4fuqoa70009pb0fcz8xux9z	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2903-SERRAA0	8	25555	2025-07-10 00:00:00	2024-12-08 17:02:45.082	798391844		2024-12-20 18:55:37.917
cm4fuqoa7000apb0fd8th7ejr	cm4fuqoa70001pb0fn2qsr32l	waiting	https://download.gerencianet.com.br/v1/275362_384_MALDRA8/275362-2896-ENALE8/275362-2904-MEHTA4	9	25555	2025-08-10 00:00:00	2024-12-08 17:02:45.082	798391845		2024-12-20 18:55:37.917
cm4furg4i000opb0fxp4nj85r	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2905-BORRA6	1	25555	2024-12-10 00:00:00	2024-12-08 17:03:21.186	798391927		2024-12-20 18:55:37.917
cm4furg4i000ppb0fh73nw3e1	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2906-DALE6	2	25555	2025-01-10 00:00:00	2024-12-08 17:03:21.186	798391928		2024-12-20 18:55:37.917
cm4furg4i000qpb0f5iemdm79	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2907-CORLE5	3	25555	2025-02-10 00:00:00	2024-12-08 17:03:21.186	798391929		2024-12-20 18:55:37.917
cm4furg4i000rpb0f21fzscw3	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2908-MALBO5	4	25555	2025-03-10 00:00:00	2024-12-08 17:03:21.186	798391930		2024-12-20 18:55:37.917
cm4furg4i000spb0fs4beosq6	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2909-RAAENA3	5	25555	2025-04-10 00:00:00	2024-12-08 17:03:21.186	798391931		2024-12-20 18:55:37.917
cm4furg4i000tpb0fdv89x3ci	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2910-DALEO6	6	25555	2025-05-10 00:00:00	2024-12-08 17:03:21.186	798391932		2024-12-20 18:55:37.917
cm4furg4i000upb0fikem2zsh	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2911-HILEO2	7	25555	2025-06-10 00:00:00	2024-12-08 17:03:21.186	798391933		2024-12-20 18:55:37.917
cm4furg4i000vpb0fv8bhz7jk	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2912-LUASI1	8	25555	2025-07-10 00:00:00	2024-12-08 17:03:21.186	798391934		2024-12-20 18:55:37.917
cm4furg4i000wpb0ffoc1ym58	cm4furg4h000npb0ff4mofm08	waiting	https://download.gerencianet.com.br/v1/275362_385_DRONEM0/275362-2905-BORRA6/275362-2913-CORSI0	9	25555	2025-08-10 00:00:00	2024-12-08 17:03:21.186	798391935		2024-12-20 18:55:37.917
cm4furl0u001apb0flg385cqh	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2914-TAPA4	1	25555	2024-12-10 00:00:00	2024-12-08 17:03:27.534	798391959		2024-12-20 18:55:37.917
cm4furl0u001bpb0fxm3fdvs4	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2915-SERCHO5	2	25555	2025-01-10 00:00:00	2024-12-08 17:03:27.534	798391960		2024-12-20 18:55:37.917
cm4furl0u001cpb0fwr1rse5q	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2916-DODA8	3	25555	2025-02-10 00:00:00	2024-12-08 17:03:27.534	798391961		2024-12-20 18:55:37.917
cm4furl0u001dpb0f3h2i7jm3	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2917-LOHI3	4	25555	2025-03-10 00:00:00	2024-12-08 17:03:27.534	798391962		2024-12-20 18:55:37.917
cm4furl0u001epb0fx8w55r3m	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2918-LUASI4	5	25555	2025-04-10 00:00:00	2024-12-08 17:03:27.534	798391963		2024-12-20 18:55:37.917
cm4furl0u001fpb0fk6siqaur	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2919-LEONEM5	6	25555	2025-05-10 00:00:00	2024-12-08 17:03:27.534	798391964		2024-12-20 18:55:37.917
cm4furl0u001gpb0fvi9hznun	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2920-DORRA4	7	25555	2025-06-10 00:00:00	2024-12-08 17:03:27.534	798391965		2024-12-20 18:55:37.917
cm4furl0u001hpb0fnwx79nc5	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2921-TASI2	8	25555	2025-07-10 00:00:00	2024-12-08 17:03:27.534	798391966		2024-12-20 18:55:37.917
cm4furl0u001ipb0fi9tp34ct	cm4furl0u0019pb0f0l51eerb	waiting	https://download.gerencianet.com.br/v1/275362_386_BRACA5/275362-2914-TAPA4/275362-2922-CORLUA3	9	25555	2025-08-10 00:00:00	2024-12-08 17:03:27.534	798391967		2024-12-20 18:55:37.917
cm4furp83001wpb0f59u3qnwq	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2923-MEHCA1	1	25555	2024-12-10 00:00:00	2024-12-08 17:03:32.979	798391979		2024-12-20 18:55:37.917
cm4furp83001xpb0f5jfardov	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2924-LOCHO8	2	25555	2025-01-10 00:00:00	2024-12-08 17:03:32.979	798391980		2024-12-20 18:55:37.917
cm4furp83001ypb0fqrau0mit	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2925-DRAMEH1	3	25555	2025-02-10 00:00:00	2024-12-08 17:03:32.979	798391981		2024-12-20 18:55:37.917
cm4furp83001zpb0fax2w1tl2	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2926-MALDO9	4	25555	2025-03-10 00:00:00	2024-12-08 17:03:32.979	798391982		2024-12-20 18:55:37.917
cm4furp830020pb0flejcbhg7	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2927-CORLO9	5	25555	2025-04-10 00:00:00	2024-12-08 17:03:32.979	798391983		2024-12-20 18:55:37.917
cm4furp830021pb0faas0mfpw	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2928-ZECHO8	6	25555	2025-05-10 00:00:00	2024-12-08 17:03:32.979	798391984		2024-12-20 18:55:37.917
cm4furp830022pb0f1bpcdqvg	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2929-DANAE3	7	25555	2025-06-10 00:00:00	2024-12-08 17:03:32.979	798391985		2024-12-20 18:55:37.917
cm4furp830023pb0fmh7wlicv	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2930-TAMA7	8	25555	2025-07-10 00:00:00	2024-12-08 17:03:32.979	798391986		2024-12-20 18:55:37.917
cm4furp830024pb0fa918zur3	cm4furp83001vpb0fxv1evbsp	waiting	https://download.gerencianet.com.br/v1/275362_387_SERBRA1/275362-2923-MEHCA1/275362-2931-LUADRA7	9	25555	2025-08-10 00:00:00	2024-12-08 17:03:32.979	798391987		2024-12-20 18:55:37.917
cm4fus75m002ipb0fzvjdioo7	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2932-BRAMEH6	1	25555	2024-12-10 00:00:00	2024-12-08 17:03:56.218	798392039		2024-12-20 18:55:37.917
cm4fus75m002jpb0fo1c7tn5c	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2933-ENADRO2	2	25555	2025-01-10 00:00:00	2024-12-08 17:03:56.218	798392040		2024-12-20 18:55:37.917
cm4fus75m002kpb0fog6s38u2	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2934-RAABRA7	3	25555	2025-02-10 00:00:00	2024-12-08 17:03:56.218	798392041		2024-12-20 18:55:37.917
cm4fus75m002lpb0fd5p44m0q	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2935-HICA8	4	25555	2025-03-10 00:00:00	2024-12-08 17:03:56.218	798392042		2024-12-20 18:55:37.917
cm4fus75n002mpb0frp02q8ud	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2936-PARAA5	5	25555	2025-04-10 00:00:00	2024-12-08 17:03:56.218	798392043		2024-12-20 18:55:37.917
cm4fus75n002npb0fb8xf718y	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2937-LEDA1	6	25555	2025-05-10 00:00:00	2024-12-08 17:03:56.218	798392044		2024-12-20 18:55:37.917
cm4fus75n002opb0f6ng698lt	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2938-SICA3	7	25555	2025-06-10 00:00:00	2024-12-08 17:03:56.218	798392045		2024-12-20 18:55:37.917
cm4fus75n002ppb0frpa8x5jp	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2939-ZEMAL4	8	25555	2025-07-10 00:00:00	2024-12-08 17:03:56.218	798392046		2024-12-20 18:55:37.917
cm4fus75n002qpb0f2hveg8nb	cm4fus75m002hpb0fy0abatkd	waiting	https://download.gerencianet.com.br/v1/275362_388_CATA4/275362-2932-BRAMEH6/275362-2940-NEMDO7	9	25555	2025-08-10 00:00:00	2024-12-08 17:03:56.218	798392047		2024-12-20 18:55:37.917
cm4fuufif0034pb0f2wep9ai7	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2941-RAARAA7	1	25555	2024-12-10 00:00:00	2024-12-08 17:05:40.359	798392271		2024-12-20 18:55:37.917
cm4fuufif0035pb0fw9lup4g3	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2942-ZENEM9	2	25555	2025-01-10 00:00:00	2024-12-08 17:05:40.359	798392272		2024-12-20 18:55:37.917
cm4fuufif0036pb0fdowzwi4a	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2943-NEMLEO3	3	25555	2025-02-10 00:00:00	2024-12-08 17:05:40.359	798392273		2024-12-20 18:55:37.917
cm4fuufif0037pb0ffq0wvwst	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2944-ZECHO1	4	25555	2025-03-10 00:00:00	2024-12-08 17:05:40.359	798392274		2024-12-20 18:55:37.917
cm4fuufif0038pb0fjqn0aoam	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2945-MAENA1	5	25555	2025-04-10 00:00:00	2024-12-08 17:05:40.359	798392275		2024-12-20 18:55:37.917
cm4fuufif0039pb0f7jhzrd4m	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2946-LOPA6	6	25555	2025-05-10 00:00:00	2024-12-08 17:05:40.359	798392276		2024-12-20 18:55:37.917
cm4fuufif003apb0fgbvrusxr	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2947-BRAMA4	7	25555	2025-06-10 00:00:00	2024-12-08 17:05:40.359	798392277		2024-12-20 18:55:37.917
cm4fuufif003bpb0fb93dqtf5	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2948-BRALO5	8	25555	2025-07-10 00:00:00	2024-12-08 17:05:40.359	798392278		2024-12-20 18:55:37.917
cm4fuufif003cpb0fklgfvad7	cm4fuufie0033pb0fg3x86l4n	waiting	https://download.gerencianet.com.br/v1/275362_389_BRADRO2/275362-2941-RAARAA7/275362-2949-DAZE2	9	25555	2025-08-10 00:00:00	2024-12-08 17:05:40.359	798392279		2024-12-20 18:55:37.917
cm4fuukqq003qpb0f2epev66g	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2950-LEOHI1	1	25555	2024-12-10 00:00:00	2024-12-08 17:05:47.139	798392287		2024-12-20 18:55:37.917
cm4fuukqq003rpb0fk1gojtw0	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2951-ENAHI5	2	25555	2025-01-10 00:00:00	2024-12-08 17:05:47.139	798392288		2024-12-20 18:55:37.917
cm4fuukqq003spb0fv4cb9a0i	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2952-DRACOR3	3	25555	2025-02-10 00:00:00	2024-12-08 17:05:47.139	798392289		2024-12-20 18:55:37.917
cm4fuukqq003tpb0f9ktaljuf	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2953-PAHI1	4	25555	2025-03-10 00:00:00	2024-12-08 17:05:47.139	798392290		2024-12-20 18:55:37.917
cm4fuukqr003upb0f43jfl8or	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2954-LOLO7	5	25555	2025-04-10 00:00:00	2024-12-08 17:05:47.139	798392291		2024-12-20 18:55:37.917
cm4fuukqr003vpb0fngyv4fqm	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2955-NAEHI2	6	25555	2025-05-10 00:00:00	2024-12-08 17:05:47.139	798392292		2024-12-20 18:55:37.917
cm4fuukqr003wpb0fg7tpgy6w	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2956-NAENEM1	7	25555	2025-06-10 00:00:00	2024-12-08 17:05:47.139	798392293		2024-12-20 18:55:37.917
cm4fuukqr003xpb0fupvbh6m3	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2957-TAENA7	8	25555	2025-07-10 00:00:00	2024-12-08 17:05:47.139	798392294		2024-12-20 18:55:37.917
cm4fuukqr003ypb0fefard2mv	cm4fuukqq003ppb0f7g2lavsr	waiting	https://download.gerencianet.com.br/v1/275362_390_NAEDO0/275362-2950-LEOHI1/275362-2958-NEMCOR9	9	25555	2025-08-10 00:00:00	2024-12-08 17:05:47.139	798392295		2024-12-20 18:55:37.917
cm4fuupbv004cpb0fpq98sunp	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2959-BRAMAL3	1	25555	2024-12-10 00:00:00	2024-12-08 17:05:53.083	798392303		2024-12-20 18:55:37.917
cm4fuupbv004dpb0f1tpvl3ky	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2960-BRAFO0	2	25555	2025-01-10 00:00:00	2024-12-08 17:05:53.083	798392304		2024-12-20 18:55:37.917
cm4fuupbv004epb0fmj867toe	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2961-CORFO3	3	25555	2025-02-10 00:00:00	2024-12-08 17:05:53.083	798392305		2024-12-20 18:55:37.917
cm4fuupbv004fpb0f9hosiyd5	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2962-DROLE4	4	25555	2025-03-10 00:00:00	2024-12-08 17:05:53.083	798392306		2024-12-20 18:55:37.917
cm4fuupbv004gpb0f36aawwnv	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2963-CADO7	5	25555	2025-04-10 00:00:00	2024-12-08 17:05:53.083	798392307		2024-12-20 18:55:37.917
cm4fuupbv004hpb0f915hf54g	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2964-DACA9	6	25555	2025-05-10 00:00:00	2024-12-08 17:05:53.083	798392308		2024-12-20 18:55:37.917
cm4fuupbv004ipb0fxj5oiwdb	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2965-LEONAE2	7	25555	2025-06-10 00:00:00	2024-12-08 17:05:53.083	798392309		2024-12-20 18:55:37.917
cm4fuupbv004jpb0f0o0pd5is	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2966-FOBO6	8	25555	2025-07-10 00:00:00	2024-12-08 17:05:53.083	798392310		2024-12-20 18:55:37.917
cm4fuupbv004kpb0f8iu0t619	cm4fuupbv004bpb0fx8m6tk3t	waiting	https://download.gerencianet.com.br/v1/275362_391_DROMAL2/275362-2959-BRAMAL3/275362-2967-DAENA3	9	25555	2025-08-10 00:00:00	2024-12-08 17:05:53.083	798392311		2024-12-20 18:55:37.917
cm4fuvo9q004ypb0fzwj830qo	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2968-MACOR4	1	25555	2024-12-10 00:00:00	2024-12-08 17:06:38.366	798392404		2024-12-20 18:55:37.917
cm4fuvo9q004zpb0fb07d1mtq	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2969-PARRA1	2	25555	2025-01-10 00:00:00	2024-12-08 17:06:38.366	798392405		2024-12-20 18:55:37.917
cm4fuvo9q0050pb0fdeitrg2h	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2970-LOENA3	3	25555	2025-02-10 00:00:00	2024-12-08 17:06:38.366	798392406		2024-12-20 18:55:37.917
cm4fuvo9q0051pb0fbnm5nx9d	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2971-DODRA2	4	25555	2025-03-10 00:00:00	2024-12-08 17:06:38.366	798392407		2024-12-20 18:55:37.917
cm4fuvo9q0052pb0fgapum98e	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2972-ENALO0	5	25555	2025-04-10 00:00:00	2024-12-08 17:06:38.366	798392408		2024-12-20 18:55:37.917
cm4fuvo9q0053pb0fjouhezb3	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2973-RRAPA9	6	25555	2025-05-10 00:00:00	2024-12-08 17:06:38.366	798392409		2024-12-20 18:55:37.917
cm4fuvo9q0054pb0f8pamipmn	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2974-ENAPA3	7	25555	2025-06-10 00:00:00	2024-12-08 17:06:38.366	798392410		2024-12-20 18:55:37.917
cm4fuvo9q0055pb0fxdmx62t7	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2975-DOMEH1	8	25555	2025-07-10 00:00:00	2024-12-08 17:06:38.366	798392411		2024-12-20 18:55:37.917
cm4fuvo9q0056pb0fkwc9acal	cm4fuvo9q004xpb0fv1qia8w1	waiting	https://download.gerencianet.com.br/v1/275362_392_CACA7/275362-2968-MACOR4/275362-2976-DABRA1	9	25555	2025-08-10 00:00:00	2024-12-08 17:06:38.366	798392412		2024-12-20 18:55:37.917
cm4fuvs96005kpb0f2tpevdgs	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2977-CACHO1	1	25555	2024-12-10 00:00:00	2024-12-08 17:06:43.53	798392416		2024-12-20 18:55:37.917
cm4fuvs96005lpb0fwijkdom3	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2978-BRAHI6	2	25555	2025-01-10 00:00:00	2024-12-08 17:06:43.53	798392417		2024-12-20 18:55:37.917
cm4fuvs96005mpb0ffzjybqrq	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2979-NEMLUA5	3	25555	2025-02-10 00:00:00	2024-12-08 17:06:43.53	798392418		2024-12-20 18:55:37.917
cm4fuvs96005npb0ff0p8kuor	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2980-SIRAA1	4	25555	2025-03-10 00:00:00	2024-12-08 17:06:43.53	798392419		2024-12-20 18:55:37.917
cm4fuvs96005opb0fij4u058e	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2981-DOZE6	5	25555	2025-04-10 00:00:00	2024-12-08 17:06:43.53	798392420		2024-12-20 18:55:37.917
cm4fuvs96005ppb0f9ifcldp0	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2982-TANEM1	6	25555	2025-05-10 00:00:00	2024-12-08 17:06:43.53	798392421		2024-12-20 18:55:37.917
cm4fuvs96005qpb0fi320foaq	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2983-PANAE6	7	25555	2025-06-10 00:00:00	2024-12-08 17:06:43.53	798392422		2024-12-20 18:55:37.917
cm4fuvs96005rpb0fftmmw2v1	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2984-NAEZE2	8	25555	2025-07-10 00:00:00	2024-12-08 17:06:43.53	798392423		2024-12-20 18:55:37.917
cm4fuvs96005spb0fpp5os3ef	cm4fuvs95005jpb0fw4c0mnuk	waiting	https://download.gerencianet.com.br/v1/275362_393_SERDO7/275362-2977-CACHO1/275362-2985-LOLEO9	9	25555	2025-08-10 00:00:00	2024-12-08 17:06:43.53	798392424		2024-12-20 18:55:37.917
cm4fuvvlw0066pb0fed6oazdp	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2986-DALEO5	1	25555	2024-12-10 00:00:00	2024-12-08 17:06:47.876	798392439		2024-12-20 18:55:37.917
cm4fuvvlw0067pb0fs9bxk7n9	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2987-DAHI8	2	25555	2025-01-10 00:00:00	2024-12-08 17:06:47.876	798392440		2024-12-20 18:55:37.917
cm4fuvvlw0068pb0fbee54z9d	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2988-PADRA0	3	25555	2025-02-10 00:00:00	2024-12-08 17:06:47.876	798392441		2024-12-20 18:55:37.917
cm4fuvvlw0069pb0fcizjlph7	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2989-MEHZE6	4	25555	2025-03-10 00:00:00	2024-12-08 17:06:47.876	798392442		2024-12-20 18:55:37.917
cm4fuvvlw006apb0f8ctc4gee	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2990-RRACHO6	5	25555	2025-04-10 00:00:00	2024-12-08 17:06:47.876	798392443		2024-12-20 18:55:37.917
cm4fuvvlw006bpb0fo1xvfsow	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2991-DOPA0	6	25555	2025-05-10 00:00:00	2024-12-08 17:06:47.876	798392444		2024-12-20 18:55:37.917
cm4fuvvlw006cpb0fe8z9lmp3	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2992-CANAE9	7	25555	2025-06-10 00:00:00	2024-12-08 17:06:47.876	798392445		2024-12-20 18:55:37.917
cm4fuvvlw006dpb0f64u5s8yk	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2993-ZELUA6	8	25555	2025-07-10 00:00:00	2024-12-08 17:06:47.876	798392446		2024-12-20 18:55:37.917
cm4fuvvlw006epb0fjofjimdz	cm4fuvvlw0065pb0f61hxbiep	waiting	https://download.gerencianet.com.br/v1/275362_394_CASER2/275362-2986-DALEO5/275362-2994-SIMEH7	9	25555	2025-08-10 00:00:00	2024-12-08 17:06:47.876	798392447		2024-12-20 18:55:37.917
cm4fuvz2w006spb0frkg4e1mq	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-2995-NEMSER6	1	25555	2024-12-10 00:00:00	2024-12-08 17:06:52.376	798392464		2024-12-20 18:55:37.917
cm4fuvz2w006tpb0f0hmkp148	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-2996-NEMLO8	2	25555	2025-01-10 00:00:00	2024-12-08 17:06:52.376	798392465		2024-12-20 18:55:37.917
cm4fuvz2w006upb0f7i85sew5	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-2997-CATA2	3	25555	2025-02-10 00:00:00	2024-12-08 17:06:52.376	798392466		2024-12-20 18:55:37.917
cm4fuvz2w006vpb0ftw919ebb	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-2998-RAAENA4	4	25555	2025-03-10 00:00:00	2024-12-08 17:06:52.376	798392467		2024-12-20 18:55:37.917
cm4fuvz2w006wpb0ful1ttt83	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-2999-MEHLE1	5	25555	2025-04-10 00:00:00	2024-12-08 17:06:52.376	798392468		2024-12-20 18:55:37.917
cm4fuvz2w006xpb0fuq1ykeyi	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-3000-CHOTA1	6	25555	2025-05-10 00:00:00	2024-12-08 17:06:52.376	798392469		2024-12-20 18:55:37.917
cm4fuvz2w006ypb0fnqx8np2d	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-3001-BOLUA0	7	25555	2025-06-10 00:00:00	2024-12-08 17:06:52.376	798392470		2024-12-20 18:55:37.917
cm4fuvz2w006zpb0fcfyyv10r	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-3002-CHOLEO3	8	25555	2025-07-10 00:00:00	2024-12-08 17:06:52.376	798392471		2024-12-20 18:55:37.917
cm4fuvz2w0070pb0fpcoy1ulq	cm4fuvz2w006rpb0f5qgtr8fh	waiting	https://download.gerencianet.com.br/v1/275362_395_NAEXI3/275362-2995-NEMSER6/275362-3003-NEMENA5	9	25555	2025-08-10 00:00:00	2024-12-08 17:06:52.376	798392472		2024-12-20 18:55:37.917
cm4fuw41c007epb0fq0mzp1hq	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3004-XICOR8	1	25555	2024-12-10 00:00:00	2024-12-08 17:06:58.8	798392479		2024-12-20 18:55:37.917
cm4fuw41c007fpb0f1vf7shax	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3005-SERBRA8	2	25555	2025-01-10 00:00:00	2024-12-08 17:06:58.8	798392480		2024-12-20 18:55:37.917
cm4fuw41c007gpb0fzyijg8z7	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3006-CORDRA5	3	25555	2025-02-10 00:00:00	2024-12-08 17:06:58.8	798392481		2024-12-20 18:55:37.917
cm4fuw41c007hpb0f72g4ug0u	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3007-LEOBO2	4	25555	2025-03-10 00:00:00	2024-12-08 17:06:58.8	798392482		2024-12-20 18:55:37.917
cm4fuw41c007ipb0f8ownc3zj	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3008-SERLA5	5	25555	2025-04-10 00:00:00	2024-12-08 17:06:58.8	798392483		2024-12-20 18:55:37.917
cm4fuw41c007jpb0fs9pq01c8	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3009-LODA7	6	25555	2025-05-10 00:00:00	2024-12-08 17:06:58.8	798392484		2024-12-20 18:55:37.917
cm4fuw41c007kpb0fboo8xseq	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3010-BOLEO8	7	25555	2025-06-10 00:00:00	2024-12-08 17:06:58.8	798392485		2024-12-20 18:55:37.917
cm4fuw41c007lpb0fxget77ok	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3011-NAENEM8	8	25555	2025-07-10 00:00:00	2024-12-08 17:06:58.8	798392486		2024-12-20 18:55:37.917
cm4fuw41c007mpb0fbgihh0g6	cm4fuw41c007dpb0fjq6ew3fs	waiting	https://download.gerencianet.com.br/v1/275362_396_LEHI4/275362-3004-XICOR8/275362-3012-LASER3	9	25555	2025-08-10 00:00:00	2024-12-08 17:06:58.8	798392487		2024-12-20 18:55:37.917
cm4fuwb300080pb0f52wwm5by	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3013-BRALUA2	1	25555	2024-12-10 00:00:00	2024-12-08 17:07:07.932	798392507		2024-12-20 18:55:37.917
cm4fuwb300081pb0fm3jwk9zm	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3014-BRADRA7	2	25555	2025-01-10 00:00:00	2024-12-08 17:07:07.932	798392508		2024-12-20 18:55:37.917
cm4fuwb300082pb0fkasyzp76	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3015-ENANEM6	3	25555	2025-02-10 00:00:00	2024-12-08 17:07:07.932	798392509		2024-12-20 18:55:37.917
cm4fuwb300083pb0f6fani9i6	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3016-RRAMAL4	4	25555	2025-03-10 00:00:00	2024-12-08 17:07:07.932	798392510		2024-12-20 18:55:37.917
cm4fuwb300084pb0f094v1grz	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3017-CHOCOR9	5	25555	2025-04-10 00:00:00	2024-12-08 17:07:07.932	798392511		2024-12-20 18:55:37.917
cm4fuwb300085pb0f1mbj0326	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3018-MADO9	6	25555	2025-05-10 00:00:00	2024-12-08 17:07:07.932	798392512		2024-12-20 18:55:37.917
cm4fuwb300086pb0f3ujb9ipp	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3019-LEOBRA0	7	25555	2025-06-10 00:00:00	2024-12-08 17:07:07.932	798392513		2024-12-20 18:55:37.917
cm4fuwb300087pb0fkkfrlf4s	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3020-BOLE0	8	25555	2025-07-10 00:00:00	2024-12-08 17:07:07.932	798392514		2024-12-20 18:55:37.917
cm4fuwb300088pb0f93g71jo1	cm4fuwb30007zpb0fa1v07imh	waiting	https://download.gerencianet.com.br/v1/275362_397_CALE6/275362-3013-BRALUA2/275362-3021-DAZE7	9	25555	2025-08-10 00:00:00	2024-12-08 17:07:07.932	798392515		2024-12-20 18:55:37.917
cm4fuwg7q008mpb0f7szjrc0l	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3022-MALDA2	1	25555	2024-12-10 00:00:00	2024-12-08 17:07:14.583	798392522		2024-12-20 18:55:37.917
cm4fuwg7r008npb0ff8x5st9j	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3023-LECHO9	2	25555	2025-01-10 00:00:00	2024-12-08 17:07:14.583	798392523		2024-12-20 18:55:37.917
cm4fuwg7r008opb0fiq08551g	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3024-CHOXI7	3	25555	2025-02-10 00:00:00	2024-12-08 17:07:14.583	798392524		2024-12-20 18:55:37.917
cm4fuwg7r008ppb0f6o5519lg	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3025-SIFO6	4	25555	2025-03-10 00:00:00	2024-12-08 17:07:14.583	798392525		2024-12-20 18:55:37.917
cm4fuwg7r008qpb0fivl0m3eo	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3026-MALLE2	5	25555	2025-04-10 00:00:00	2024-12-08 17:07:14.583	798392526		2024-12-20 18:55:37.917
cm4fuwg7r008rpb0f9bf6pqut	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3027-RRASER5	6	25555	2025-05-10 00:00:00	2024-12-08 17:07:14.583	798392527		2024-12-20 18:55:37.917
cm4fuwg7r008spb0fdobof6tw	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3028-DROSI0	7	25555	2025-06-10 00:00:00	2024-12-08 17:07:14.583	798392528		2024-12-20 18:55:37.917
cm4fuwg7r008tpb0fjp8908dw	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3029-ZEBRA5	8	25555	2025-07-10 00:00:00	2024-12-08 17:07:14.583	798392529		2024-12-20 18:55:37.917
cm4fuwg7r008upb0fe8cub7xr	cm4fuwg7q008lpb0fbpbyyy64	waiting	https://download.gerencianet.com.br/v1/275362_398_NEMRAA0/275362-3022-MALDA2/275362-3030-NEMBO5	9	25555	2025-08-10 00:00:00	2024-12-08 17:07:14.583	798392530		2024-12-20 18:55:37.917
cm4fuwjsk0098pb0fxjqt1amb	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3031-RAADRO8	1	25555	2024-12-10 00:00:00	2024-12-08 17:07:19.22	798392537		2024-12-20 18:55:37.917
cm4fuwjsk0099pb0f84rvyk9f	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3032-MEHXI9	2	25555	2025-01-10 00:00:00	2024-12-08 17:07:19.22	798392538		2024-12-20 18:55:37.917
cm4fuwjsk009apb0fntwcn76j	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3033-LEOSI9	3	25555	2025-02-10 00:00:00	2024-12-08 17:07:19.22	798392539		2024-12-20 18:55:37.917
cm4fuwjsk009bpb0fonwhw5fe	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3034-CHODRO4	4	25555	2025-03-10 00:00:00	2024-12-08 17:07:19.22	798392540		2024-12-20 18:55:37.917
cm4fuwjsk009cpb0f5f518plf	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3035-LEMEH2	5	25555	2025-04-10 00:00:00	2024-12-08 17:07:19.22	798392541		2024-12-20 18:55:37.917
cm4fuwjsk009dpb0fp2shzjx0	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3036-LEZE6	6	25555	2025-05-10 00:00:00	2024-12-08 17:07:19.22	798392542		2024-12-20 18:55:37.917
cm4fuwjsk009epb0fhk5w5kzf	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3037-MALDRO2	7	25555	2025-06-10 00:00:00	2024-12-08 17:07:19.22	798392543		2024-12-20 18:55:37.917
cm4fuwjsk009fpb0fd2ndnycb	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3038-DABRA4	8	25555	2025-07-10 00:00:00	2024-12-08 17:07:19.22	798392544		2024-12-20 18:55:37.917
cm4fuwjsk009gpb0fy30r5wf3	cm4fuwjsk0097pb0f0pc2g5ie	waiting	https://download.gerencianet.com.br/v1/275362_399_ENANEM8/275362-3031-RAADRO8/275362-3039-DRAMEH5	9	25555	2025-08-10 00:00:00	2024-12-08 17:07:19.22	798392545		2024-12-20 18:55:37.917
cm4fuwnjf009upb0fnnidefkd	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3040-LEOPA4	1	25555	2024-12-10 00:00:00	2024-12-08 17:07:24.075	798392551		2024-12-20 18:55:37.917
cm4fuwnjf009vpb0fwpfm27nm	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3041-LECA0	2	25555	2025-01-10 00:00:00	2024-12-08 17:07:24.075	798392552		2024-12-20 18:55:37.917
cm4fuwnjf009wpb0fgl3pii8a	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3042-SIHI0	3	25555	2025-02-10 00:00:00	2024-12-08 17:07:24.075	798392553		2024-12-20 18:55:37.917
cm4fuwnjf009xpb0fqlecpdnm	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3043-LEOCA8	4	25555	2025-03-10 00:00:00	2024-12-08 17:07:24.075	798392554		2024-12-20 18:55:37.917
cm4fuwnjf009ypb0fkg4ejwgr	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3044-PAXI7	5	25555	2025-04-10 00:00:00	2024-12-08 17:07:24.075	798392555		2024-12-20 18:55:37.917
cm4fuwnjf009zpb0f4ntav611	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3045-CHODRA9	6	25555	2025-05-10 00:00:00	2024-12-08 17:07:24.075	798392556		2024-12-20 18:55:37.917
cm4fuwnjf00a0pb0fhecxcilb	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3046-RAAMAL9	7	25555	2025-06-10 00:00:00	2024-12-08 17:07:24.075	798392557		2024-12-20 18:55:37.917
cm4fuwnjf00a1pb0fuywx5g07	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3047-TALEO2	8	25555	2025-07-10 00:00:00	2024-12-08 17:07:24.075	798392558		2024-12-20 18:55:37.917
cm4fuwnjf00a2pb0fo1kwn29s	cm4fuwnjf009tpb0fy3kc1gj0	waiting	https://download.gerencianet.com.br/v1/275362_400_DROLEO3/275362-3040-LEOPA4/275362-3048-DOMA2	9	25555	2025-08-10 00:00:00	2024-12-08 17:07:24.075	798392559		2024-12-20 18:55:37.917
cm4fwi5bi00agpb0flk834zm7	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3049-LESI9	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:06.51	798400496		2024-12-20 18:55:37.917
cm4fwi5bi00ahpb0fne3yj5p0	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3050-RRACA6	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:06.51	798400497		2024-12-20 18:55:37.917
cm4fwi5bi00aipb0fuct8d08l	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3051-LAXI3	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:06.51	798400498		2024-12-20 18:55:37.917
cm4fwi5bi00ajpb0f7wqgbbwv	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3052-RAASER6	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:06.51	798400499		2024-12-20 18:55:37.917
cm4fwi5bi00akpb0fui2e8jl8	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3053-XIPA6	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:06.51	798400500		2024-12-20 18:55:37.917
cm4fwi5bi00alpb0f455c78yl	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3054-LASI7	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:06.51	798400501		2024-12-20 18:55:37.917
cm4fwi5bi00ampb0fy2pxipub	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3055-CALEO8	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:06.51	798400502		2024-12-20 18:55:37.917
cm4fwi5bi00anpb0f8a1g0j9r	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3056-MAMA8	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:06.51	798400503		2024-12-20 18:55:37.917
cm4fwi5bi00aopb0fkif9qaff	cm4fwi5bi00afpb0faqjmc5bs	waiting	https://download.gerencianet.com.br/v1/275362_401_DODO5/275362-3049-LESI9/275362-3057-BOSI7	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:06.51	798400504		2024-12-20 18:55:37.917
cm4fwi9am00b2pb0f6yertlaz	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3058-CORMEH1	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:11.662	798400528		2024-12-20 18:55:37.917
cm4fwi9am00b3pb0fgzd0glqb	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3059-LALUA7	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:11.662	798400529		2024-12-20 18:55:37.917
cm4fwi9am00b4pb0f0jt94lwy	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3060-CATA6	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:11.662	798400530		2024-12-20 18:55:37.917
cm4fwi9am00b5pb0fbvqqu9m6	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3061-SERSI9	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:11.662	798400531		2024-12-20 18:55:37.917
cm4fwi9am00b6pb0f7ngb2wd7	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3062-MEHBRA1	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:11.662	798400532		2024-12-20 18:55:37.917
cm4fwi9am00b7pb0ftmxy2z36	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3063-MALENA3	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:11.662	798400533		2024-12-20 18:55:37.917
cm4fwi9am00b8pb0frxbtxu96	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3064-TAFO9	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:11.662	798400534		2024-12-20 18:55:37.917
cm4fwi9am00b9pb0fv76m9xfm	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3065-LOLUA7	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:11.662	798400535		2024-12-20 18:55:37.917
cm4fwi9am00bapb0fnjg9w55k	cm4fwi9am00b1pb0fihzi6vy8	waiting	https://download.gerencianet.com.br/v1/275362_402_DONAE3/275362-3058-CORMEH1/275362-3066-MEHMA3	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:11.662	798400536		2024-12-20 18:55:37.917
cm4fwidao00bopb0fd0a8d98l	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3067-XIZE9	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:16.848	798400562		2024-12-20 18:55:37.917
cm4fwidao00bppb0fvy0fbtxl	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3068-DROENA6	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:16.848	798400563		2024-12-20 18:55:37.917
cm4fwidao00bqpb0f085min8s	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3069-MALZE8	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:16.848	798400564		2024-12-20 18:55:37.917
cm4fwidao00brpb0fsozalnp8	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3070-MALNAE0	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:16.848	798400565		2024-12-20 18:55:37.917
cm4fwidao00bspb0fzjf72c8q	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3071-SIDA7	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:16.848	798400566		2024-12-20 18:55:37.917
cm4fwidao00btpb0f26cgvcpo	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3072-SERCHO7	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:16.848	798400567		2024-12-20 18:55:37.917
cm4fwidao00bupb0fv0ccay8h	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3073-TANEM0	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:16.848	798400568		2024-12-20 18:55:37.917
cm4fwidap00bvpb0fbxae72q1	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3074-CORDA3	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:16.848	798400569		2024-12-20 18:55:37.917
cm4fwidap00bwpb0fnxlt8abu	cm4fwidao00bnpb0fzp86kely	waiting	https://download.gerencianet.com.br/v1/275362_403_BOCA6/275362-3067-XIZE9/275362-3075-DALE4	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:16.848	798400570		2024-12-20 18:55:37.917
cm4fwih1o00capb0fh0h1nzkm	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3076-HINEM3	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:21.708	798400605		2024-12-20 18:55:37.917
cm4fwih1o00cbpb0fbjwysk86	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3077-CORZE7	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:21.708	798400606		2024-12-20 18:55:37.917
cm4fwih1o00ccpb0fn8ve3kvg	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3078-CHOLA1	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:21.708	798400607		2024-12-20 18:55:37.917
cm4fwih1o00cdpb0f1vgpacs0	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3079-DRAZE0	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:21.708	798400608		2024-12-20 18:55:37.917
cm4fwih1o00cepb0fuykwefyc	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3080-CORBRA7	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:21.708	798400609		2024-12-20 18:55:37.917
cm4fwih1o00cfpb0f807io3gc	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3081-MEHLUA2	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:21.708	798400610		2024-12-20 18:55:37.917
cm4fwih1o00cgpb0fn8tqb99s	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3082-LUAMEH4	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:21.708	798400611		2024-12-20 18:55:37.917
cm4fwih1o00chpb0f594xnyif	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3083-NEMLO8	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:21.708	798400612		2024-12-20 18:55:37.917
cm4fwih1o00cipb0fqfb7rxey	cm4fwih1n00c9pb0ffv3224ua	waiting	https://download.gerencianet.com.br/v1/275362_404_DRALA3/275362-3076-HINEM3/275362-3084-SERBRA5	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:21.708	798400613		2024-12-20 18:55:37.917
cm4fwimk400cwpb0fjq4ihr4x	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3085-BRASER4	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:28.852	798400627		2024-12-20 18:55:37.917
cm4fwimk400cxpb0fjmyi6vwv	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3086-LUALE6	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:28.852	798400628		2024-12-20 18:55:37.917
cm4fwimk400cypb0fkhnb7iby	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3087-NAENEM7	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:28.852	798400629		2024-12-20 18:55:37.917
cm4fwimk400czpb0fcfjsxkm0	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3088-LEENA2	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:28.852	798400630		2024-12-20 18:55:37.917
cm4fwimk400d0pb0ffm9sbbcz	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3089-ENABO4	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:28.852	798400631		2024-12-20 18:55:37.917
cm4fwimk400d1pb0ftztredb1	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3090-CANEM0	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:28.852	798400632		2024-12-20 18:55:37.917
cm4fwimk400d2pb0flebtsd98	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3091-ZELEO9	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:28.852	798400633		2024-12-20 18:55:37.917
cm4fwimk400d3pb0fohg6quak	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3092-LEOLE4	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:28.852	798400634		2024-12-20 18:55:37.917
cm4fwimk400d4pb0fpkxhj325	cm4fwimk400cvpb0f8tpaoobn	waiting	https://download.gerencianet.com.br/v1/275362_405_CADRA7/275362-3085-BRASER4/275362-3093-NEMPA9	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:28.852	798400635		2024-12-20 18:55:37.917
cm4fwiq7t00dipb0f8ma12pwr	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3094-CHOBO0	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:33.593	798400645		2024-12-20 18:55:37.917
cm4fwiq7t00djpb0f0a7tf64b	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3095-ZEMA3	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:33.593	798400646		2024-12-20 18:55:37.917
cm4fwiq7t00dkpb0fb5ier6f8	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3096-LAMAL5	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:33.593	798400647		2024-12-20 18:55:37.917
cm4fwiq7t00dlpb0flzc4bun0	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3097-FODRO3	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:33.593	798400648		2024-12-20 18:55:37.917
cm4fwiq7t00dmpb0f923b6dv0	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3098-DOLE2	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:33.593	798400649		2024-12-20 18:55:37.917
cm4fwiq7t00dnpb0fwiqg8jgx	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3099-MALFO9	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:33.593	798400650		2024-12-20 18:55:37.917
cm4fwiq7t00dopb0fyl2lqqcw	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3100-CARRA5	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:33.593	798400651		2024-12-20 18:55:37.917
cm4fwiq7t00dppb0fo3vcgv50	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3101-RRARAA1	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:33.593	798400652		2024-12-20 18:55:37.917
cm4fwiq7t00dqpb0fkm2uuq26	cm4fwiq7s00dhpb0f9j2tf41q	waiting	https://download.gerencianet.com.br/v1/275362_406_LEFO1/275362-3094-CHOBO0/275362-3102-LUABRA3	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:33.593	798400653		2024-12-20 18:55:37.917
cm4fwitsx00e4pb0fxsm14lsk	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3103-LAFO3	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:38.241	798400664		2024-12-20 18:55:37.917
cm4fwitsy00e5pb0fh2usx73l	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3104-ENABRA9	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:38.241	798400665		2024-12-20 18:55:37.917
cm4fwitsy00e6pb0f58i4jv18	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3105-HILO0	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:38.241	798400666		2024-12-20 18:55:37.917
cm4fwitsy00e7pb0fk8x4ycvf	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3106-TALE0	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:38.241	798400667		2024-12-20 18:55:37.917
cm4fwitsy00e8pb0fvfsur2ly	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3107-SIMA9	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:38.241	798400668		2024-12-20 18:55:37.917
cm4fwitsy00e9pb0fzxkpkcrn	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3108-CADA0	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:38.241	798400669		2024-12-20 18:55:37.917
cm4fwitsy00eapb0fk1r2urul	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3109-LOHI9	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:38.241	798400670		2024-12-20 18:55:37.917
cm4fwitsy00ebpb0fvav6xhzf	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3110-RRADO9	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:38.241	798400671		2024-12-20 18:55:37.917
cm4fwitsy00ecpb0fsr2hye9i	cm4fwitsx00e3pb0fjh7ngskl	waiting	https://download.gerencianet.com.br/v1/275362_407_RRASI4/275362-3103-LAFO3/275362-3111-BRAMAL1	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:38.241	798400672		2024-12-20 18:55:37.917
cm4fwixfq00eqpb0fs2sipcot	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3112-TATA0	1	25555	2024-12-10 00:00:00	2024-12-08 17:52:42.95	798400685		2024-12-20 18:55:37.917
cm4fwixfq00erpb0f3hx8pxq8	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3113-XIDRA4	2	25555	2025-01-10 00:00:00	2024-12-08 17:52:42.95	798400686		2024-12-20 18:55:37.917
cm4fwixfq00espb0f19d75oz9	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3114-MALLUA7	3	25555	2025-02-10 00:00:00	2024-12-08 17:52:42.95	798400687		2024-12-20 18:55:37.917
cm4fwixfq00etpb0ffijt9sh7	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3115-CHODRA5	4	25555	2025-03-10 00:00:00	2024-12-08 17:52:42.95	798400688		2024-12-20 18:55:37.917
cm4fwixfq00eupb0f6p5eml8q	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3116-MAHI8	5	25555	2025-04-10 00:00:00	2024-12-08 17:52:42.95	798400689		2024-12-20 18:55:37.917
cm4fwixfq00evpb0fj9j98tt2	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3117-LECOR6	6	25555	2025-05-10 00:00:00	2024-12-08 17:52:42.95	798400690		2024-12-20 18:55:37.917
cm4fwixfq00ewpb0fe81fyq3a	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3118-LOZE0	7	25555	2025-06-10 00:00:00	2024-12-08 17:52:42.95	798400691		2024-12-20 18:55:37.917
cm4fwixfq00expb0fxb2oz242	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3119-BRAFO1	8	25555	2025-07-10 00:00:00	2024-12-08 17:52:42.95	798400692		2024-12-20 18:55:37.917
cm4fwixfq00eypb0figf2epbb	cm4fwixfp00eppb0fqeh3vedu	waiting	https://download.gerencianet.com.br/v1/275362_408_SIXI2/275362-3112-TATA0/275362-3120-CHOHI5	9	25555	2025-08-10 00:00:00	2024-12-08 17:52:42.95	798400693		2024-12-20 18:55:37.917
cm4fwsfv50002n10f54078v2k	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3121-CALEO4	1	25555	2024-12-10 00:00:00	2024-12-08 18:00:06.736	798402369		2024-12-20 18:55:37.917
cm4fwsfv50003n10fy8rgykj4	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3122-NEMPA0	2	25555	2025-01-10 00:00:00	2024-12-08 18:00:06.736	798402370		2024-12-20 18:55:37.917
cm4fwsfv50004n10frlx7hjd2	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3123-LABO8	3	25555	2025-02-10 00:00:00	2024-12-08 18:00:06.736	798402371		2024-12-20 18:55:37.917
cm4fwsfv50005n10fonuvpxzg	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3124-CATA1	4	25555	2025-03-10 00:00:00	2024-12-08 18:00:06.736	798402372		2024-12-20 18:55:37.917
cm4fwsfv50006n10faarpi08t	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3125-NAENAE4	5	25555	2025-04-10 00:00:00	2024-12-08 18:00:06.736	798402373		2024-12-20 18:55:37.917
cm4fwsfv50007n10fkscs1gle	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3126-LAZE8	6	25555	2025-05-10 00:00:00	2024-12-08 18:00:06.736	798402374		2024-12-20 18:55:37.917
cm4fwsfv50008n10fs7jzcqmc	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3127-CORBRA4	7	25555	2025-06-10 00:00:00	2024-12-08 18:00:06.736	798402375		2024-12-20 18:55:37.917
cm4fwsfv50009n10fvzwgibd3	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3128-LUAMA6	8	25555	2025-07-10 00:00:00	2024-12-08 18:00:06.736	798402376		2024-12-20 18:55:37.917
cm4fwsfv5000an10fhfr1bcfx	cm4fwsfv40001n10fariup7xm	waiting	https://download.gerencianet.com.br/v1/275362_409_PATA0/275362-3121-CALEO4/275362-3129-NAEPA6	9	25555	2025-08-10 00:00:00	2024-12-08 18:00:06.736	798402377		2024-12-20 18:55:37.917
cm4fwsl1a000on10f6j6jsh8d	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3130-MABRA7	1	25555	2024-12-10 00:00:00	2024-12-08 18:00:13.438	798402404		2024-12-20 18:55:37.917
cm4fwsl1a000pn10fksaw7k4g	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3131-ENAENA1	2	25555	2025-01-10 00:00:00	2024-12-08 18:00:13.438	798402405		2024-12-20 18:55:37.917
cm4fwsl1a000qn10f5s2fvvk7	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3132-CARRA9	3	25555	2025-02-10 00:00:00	2024-12-08 18:00:13.438	798402406		2024-12-20 18:55:37.917
cm4fwsl1a000rn10flewlvg82	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3133-HIFO1	4	25555	2025-03-10 00:00:00	2024-12-08 18:00:13.438	798402407		2024-12-20 18:55:37.917
cm4fwsl1a000sn10f2hkuxlai	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3134-LUABO3	5	25555	2025-04-10 00:00:00	2024-12-08 18:00:13.438	798402408		2024-12-20 18:55:37.917
cm4fwsl1a000tn10f4qagi3lr	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3135-XICA2	6	25555	2025-05-10 00:00:00	2024-12-08 18:00:13.438	798402409		2024-12-20 18:55:37.917
cm4fwsl1a000un10f93sz5ucm	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3136-ZEFO6	7	25555	2025-06-10 00:00:00	2024-12-08 18:00:13.438	798402410		2024-12-20 18:55:37.917
cm4fwsl1a000vn10f0e6o8cec	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3137-SIDO7	8	25555	2025-07-10 00:00:00	2024-12-08 18:00:13.438	798402411		2024-12-20 18:55:37.917
cm4fwsl1a000wn10fg0jxvfsx	cm4fwsl1a000nn10flec0b3qz	waiting	https://download.gerencianet.com.br/v1/275362_410_SICOR4/275362-3130-MABRA7/275362-3138-SINAE9	9	25555	2025-08-10 00:00:00	2024-12-08 18:00:13.438	798402412		2024-12-20 18:55:37.917
cm4fwsqpl001an10fpuphf0jj	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3139-LAMA4	1	25555	2024-12-10 00:00:00	2024-12-08 18:00:20.793	798402455		2024-12-20 18:55:37.917
cm4fwsqpl001bn10f0ukqiw7b	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3140-RRAMA4	2	25555	2025-01-10 00:00:00	2024-12-08 18:00:20.793	798402456		2024-12-20 18:55:37.917
cm4fwsqpl001cn10fd39ognvo	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3141-BOLUA9	3	25555	2025-02-10 00:00:00	2024-12-08 18:00:20.793	798402457		2024-12-20 18:55:37.917
cm4fwsqpl001dn10fsh205nn4	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3142-DACOR8	4	25555	2025-03-10 00:00:00	2024-12-08 18:00:20.793	798402458		2024-12-20 18:55:37.917
cm4fwsqpl001en10f96145kym	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3143-CORDA5	5	25555	2025-04-10 00:00:00	2024-12-08 18:00:20.793	798402459		2024-12-20 18:55:37.917
cm4fwsqpm001fn10fzbt0xkmk	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3144-NAEBO4	6	25555	2025-05-10 00:00:00	2024-12-08 18:00:20.793	798402460		2024-12-20 18:55:37.917
cm4fwsqpm001gn10f7nui9g59	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3145-DROPA0	7	25555	2025-06-10 00:00:00	2024-12-08 18:00:20.793	798402461		2024-12-20 18:55:37.917
cm4fwsqpm001hn10fu70gec3e	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3146-MACA7	8	25555	2025-07-10 00:00:00	2024-12-08 18:00:20.793	798402462		2024-12-20 18:55:37.917
cm4fwsqpm001in10fek763hyo	cm4fwsqpl0019n10fc1r2pgm9	waiting	https://download.gerencianet.com.br/v1/275362_411_LODA5/275362-3139-LAMA4/275362-3147-FOMA5	9	25555	2025-08-10 00:00:00	2024-12-08 18:00:20.793	798402463		2024-12-20 18:55:37.917
cm4fwsuwp001wn10fc3gjgpah	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3148-DRODO8	1	25555	2024-12-10 00:00:00	2024-12-08 18:00:26.233	798402474		2024-12-20 18:55:37.917
cm4fwsuwp001xn10f9kmk63ga	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3149-MACA1	2	25555	2025-01-10 00:00:00	2024-12-08 18:00:26.233	798402475		2024-12-20 18:55:37.917
cm4fwsuwp001yn10f919sebhz	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3150-MALBRA0	3	25555	2025-02-10 00:00:00	2024-12-08 18:00:26.233	798402476		2024-12-20 18:55:37.917
cm4fwsuwp001zn10f42yglab0	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3151-CHOLUA3	4	25555	2025-03-10 00:00:00	2024-12-08 18:00:26.233	798402477		2024-12-20 18:55:37.917
cm4fwsuwp0020n10fmklr6peh	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3152-SITA4	5	25555	2025-04-10 00:00:00	2024-12-08 18:00:26.233	798402478		2024-12-20 18:55:37.917
cm4fwsuwp0021n10fcxuxhuo2	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3153-MAZE5	6	25555	2025-05-10 00:00:00	2024-12-08 18:00:26.233	798402479		2024-12-20 18:55:37.917
cm4fwsuwp0022n10faag0h7x8	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3154-DACA1	7	25555	2025-06-10 00:00:00	2024-12-08 18:00:26.233	798402480		2024-12-20 18:55:37.917
cm4fwsuwp0023n10fw59xxygk	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3155-SISER9	8	25555	2025-07-10 00:00:00	2024-12-08 18:00:26.233	798402481		2024-12-20 18:55:37.917
cm4fwsuwp0024n10fr17dz06w	cm4fwsuwp001vn10flnmxrxgd	waiting	https://download.gerencianet.com.br/v1/275362_412_LEBO2/275362-3148-DRODO8/275362-3156-RAAHI0	9	25555	2025-08-10 00:00:00	2024-12-08 18:00:26.233	798402482		2024-12-20 18:55:37.917
cm4fyz3l2002in10f5in4f49b	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3157-CORDO1	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:16.646	798411590		2024-12-20 18:55:37.917
cm4fyz3l2002jn10fkshtov81	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3158-NEMDO1	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:16.646	798411591		2024-12-20 18:55:37.917
cm4fyz3l2002kn10f06xerxyr	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3159-NAECA9	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:16.646	798411592		2024-12-20 18:55:37.917
cm4fyz3l2002ln10fcox6aw51	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3160-CHOMAL3	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:16.646	798411593		2024-12-20 18:55:37.917
cm4fyz3l2002mn10fdo28zhny	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3161-SIFO9	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:16.646	798411594		2024-12-20 18:55:37.917
cm4fyz3l2002nn10fb9duvul5	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3162-PAMA6	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:16.646	798411595		2024-12-20 18:55:37.917
cm4fyz3l2002on10fgype5opp	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3163-MEHPA9	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:16.646	798411596		2024-12-20 18:55:37.917
cm4fyz3l2002pn10frx9m511n	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3164-ENALEO9	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:16.646	798411597		2024-12-20 18:55:37.917
cm4fyz3l2002qn10fvihm6f24	cm4fyz3l1002hn10f1sk915m1	waiting	https://download.gerencianet.com.br/v1/275362_413_BORRA9/275362-3157-CORDO1/275362-3165-RAAZE7	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:16.646	798411598		2024-12-20 18:55:37.917
cm4fyz8h20034n10ftgbx2pb1	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3166-ZEHI2	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:22.982	798411603		2024-12-20 18:55:37.917
cm4fyz8h20035n10f798l9t4x	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3167-CADO5	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:22.982	798411604		2024-12-20 18:55:37.917
cm4fyz8h20036n10fcmm1whlk	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3168-FOCOR4	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:22.982	798411605		2024-12-20 18:55:37.917
cm4fyz8h20037n10fikna0eak	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3169-MEHHI0	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:22.982	798411606		2024-12-20 18:55:37.917
cm4fyz8h20038n10fpkqbj127	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3170-LOCA8	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:22.982	798411607		2024-12-20 18:55:37.917
cm4fyz8h20039n10fr1airh8d	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3171-BOTA9	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:22.982	798411608		2024-12-20 18:55:37.917
cm4fyz8h2003an10f0md7r1t6	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3172-LOCHO2	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:22.982	798411609		2024-12-20 18:55:37.917
cm4fyz8h2003bn10feq8qfdmy	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3173-MADRA4	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:22.982	798411610		2024-12-20 18:55:37.917
cm4fyz8h2003cn10fy4v01tsi	cm4fyz8h20033n10fvywmos9p	waiting	https://download.gerencianet.com.br/v1/275362_414_CORCOR7/275362-3166-ZEHI2/275362-3174-DOFO5	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:22.982	798411611		2024-12-20 18:55:37.917
cm4fyzckp003qn10fm3bqgn3g	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3175-TACA2	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:28.297	798411644		2024-12-20 18:55:37.917
cm4fyzckp003rn10fxqtixrwp	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3176-CHOMAL7	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:28.297	798411645		2024-12-20 18:55:37.917
cm4fyzckp003sn10frl7a41m5	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3177-RRAXI3	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:28.297	798411646		2024-12-20 18:55:37.917
cm4fyzckp003tn10flhs72tal	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3178-PAENA8	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:28.297	798411647		2024-12-20 18:55:37.917
cm4fyzckp003un10fg94xf9wq	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3179-MEHMA0	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:28.297	798411648		2024-12-20 18:55:37.917
cm4fyzckp003vn10fwz1t3sl0	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3180-BRALE3	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:28.297	798411649		2024-12-20 18:55:37.917
cm4fyzckp003wn10fd4u0wzot	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3181-ZEBRA7	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:28.297	798411650		2024-12-20 18:55:37.917
cm4fyzckp003xn10f0acgxyie	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3182-CORLUA7	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:28.297	798411651		2024-12-20 18:55:37.917
cm4fyzckp003yn10ftn5mwwrf	cm4fyzckp003pn10fwrltk79q	waiting	https://download.gerencianet.com.br/v1/275362_415_DOMAL1/275362-3175-TACA2/275362-3183-ENARRA3	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:28.297	798411652		2024-12-20 18:55:37.917
cm4fyzgix004cn10fu9crkelk	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3184-CHOZE4	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:33.417	798411659		2024-12-20 18:55:37.917
cm4fyzgix004dn10fdrualwua	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3185-SICHO8	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:33.417	798411660		2024-12-20 18:55:37.917
cm4fyzgix004en10fedhm8ge9	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3186-BOTA9	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:33.417	798411661		2024-12-20 18:55:37.917
cm4fyzgix004fn10fmdg430v0	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3187-DROLUA5	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:33.417	798411662		2024-12-20 18:55:37.917
cm4fyzgix004gn10f1o3pv5dk	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3188-DROPA0	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:33.417	798411663		2024-12-20 18:55:37.917
cm4fyzgix004hn10f9ta5fs51	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3189-DORAA0	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:33.417	798411664		2024-12-20 18:55:37.917
cm4fyzgix004in10fynamkp0q	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3190-HITA3	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:33.417	798411665		2024-12-20 18:55:37.917
cm4fyzgix004jn10fzcl7g7i2	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3191-NEMENA3	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:33.417	798411666		2024-12-20 18:55:37.917
cm4fyzgix004kn10f5djtdp7v	cm4fyzgix004bn10feswpl3g3	waiting	https://download.gerencianet.com.br/v1/275362_416_LEOENA6/275362-3184-CHOZE4/275362-3192-LALUA3	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:33.417	798411667		2024-12-20 18:55:37.917
cm4fyzk4v004yn10f3pp2iuuo	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3193-MALBO3	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:38.095	798411669		2024-12-20 18:55:37.917
cm4fyzk4v004zn10f3c3e2996	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3194-TAENA0	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:38.095	798411670		2024-12-20 18:55:37.917
cm4fyzk4v0050n10f61kjnqxo	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3195-LACHO0	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:38.095	798411671		2024-12-20 18:55:37.917
cm4fyzk4v0051n10fow3jj9cm	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3196-DRAMAL1	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:38.095	798411672		2024-12-20 18:55:37.917
cm4fyzk4v0052n10fzj69chgo	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3197-LOMEH2	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:38.095	798411673		2024-12-20 18:55:37.917
cm4fyzk4v0053n10fg840fn81	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3198-CORNEM1	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:38.095	798411674		2024-12-20 18:55:37.917
cm4fyzk4v0054n10fytykqfnb	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3199-CORCA9	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:38.095	798411675		2024-12-20 18:55:37.917
cm4fyzk4v0055n10fmpfko86q	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3200-CANAE1	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:38.095	798411676		2024-12-20 18:55:37.917
cm4fyzk4v0056n10fv0x2ysdy	cm4fyzk4v004xn10fahxrtyqh	waiting	https://download.gerencianet.com.br/v1/275362_417_NEMMAL4/275362-3193-MALBO3/275362-3201-BRADRO1	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:38.095	798411677		2024-12-20 18:55:37.917
cm4fyzo62005kn10fl2od70fg	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3202-XIBO8	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:43.322	798411683		2024-12-20 18:55:37.917
cm4fyzo62005ln10fen56m4dm	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3203-XIDRO7	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:43.322	798411684		2024-12-20 18:55:37.917
cm4fyzo62005mn10frxf00idv	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3204-LELEO7	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:43.322	798411685		2024-12-20 18:55:37.917
cm4fyzo62005nn10fl1kx3adw	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3205-DRALA9	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:43.322	798411686		2024-12-20 18:55:37.917
cm4fyzo62005on10ft80ipcm1	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3206-RAANEM0	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:43.322	798411687		2024-12-20 18:55:37.917
cm4fyzo62005pn10fzut05rnl	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3207-PACHO2	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:43.322	798411688		2024-12-20 18:55:37.917
cm4fyzo62005qn10f5zz8rcyx	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3208-ZERRA3	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:43.322	798411689		2024-12-20 18:55:37.917
cm4fyzo62005rn10fut32z5je	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3209-LOMAL8	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:43.322	798411690		2024-12-20 18:55:37.917
cm4fyzo62005sn10f2jbzqx3p	cm4fyzo62005jn10fgpvsjpql	waiting	https://download.gerencianet.com.br/v1/275362_418_CASI8/275362-3202-XIBO8/275362-3210-LEOXI0	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:43.322	798411691		2024-12-20 18:55:37.917
cm4fyzrwl0066n10ftcwyy1po	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3211-LEBRA6	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:48.165	798411697		2024-12-20 18:55:37.917
cm4fyzrwl0067n10fj6k0w2rt	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3212-XICA6	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:48.165	798411698		2024-12-20 18:55:37.917
cm4fyzrwl0068n10fa5dk5npd	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3213-ZEMEH9	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:48.165	798411699		2024-12-20 18:55:37.917
cm4fyzrwl0069n10fxvj3tvnk	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3214-RAASI6	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:48.165	798411700		2024-12-20 18:55:37.917
cm4fyzrwl006an10fnw18babb	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3215-ZELUA0	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:48.165	798411701		2024-12-20 18:55:37.917
cm4fyzrwl006bn10fjhiev82g	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3216-DOTA0	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:48.165	798411702		2024-12-20 18:55:37.917
cm4fyzrwl006cn10fwswwrpm9	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3217-BOXI1	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:48.165	798411703		2024-12-20 18:55:37.917
cm4fyzrwm006dn10fn1lu1zir	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3218-DRALO6	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:48.165	798411704		2024-12-20 18:55:37.917
cm4fyzrwm006en10ftod47sqj	cm4fyzrwl0065n10feb09kp2d	waiting	https://download.gerencianet.com.br/v1/275362_419_MEHRRA6/275362-3211-LEBRA6/275362-3219-RRADO5	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:48.165	798411705		2024-12-20 18:55:37.917
cm4fyzvi7006sn10f46njbhmr	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3220-SERENA1	1	25555	2024-12-10 00:00:00	2024-12-08 19:01:52.831	798411712		2024-12-20 18:55:37.917
cm4fyzvi7006tn10fagbh82cd	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3221-NAESI3	2	25555	2025-01-10 00:00:00	2024-12-08 19:01:52.831	798411713		2024-12-20 18:55:37.917
cm4fyzvi7006un10f62eriz89	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3222-RRAZE5	3	25555	2025-02-10 00:00:00	2024-12-08 19:01:52.831	798411714		2024-12-20 18:55:37.917
cm4fyzvi7006vn10fsn3ank4o	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3223-LEBRA4	4	25555	2025-03-10 00:00:00	2024-12-08 19:01:52.831	798411715		2024-12-20 18:55:37.917
cm4fyzvi7006wn10f09wh1trd	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3224-DROMAL9	5	25555	2025-04-10 00:00:00	2024-12-08 19:01:52.831	798411716		2024-12-20 18:55:37.917
cm4fyzvi7006xn10f4w258fty	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3225-RAAPA5	6	25555	2025-05-10 00:00:00	2024-12-08 19:01:52.831	798411717		2024-12-20 18:55:37.917
cm4fyzvi7006yn10f29m4d3oj	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3226-CASER0	7	25555	2025-06-10 00:00:00	2024-12-08 19:01:52.831	798411718		2024-12-20 18:55:37.917
cm4fyzvi7006zn10f1ps3frrg	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3227-LOBO0	8	25555	2025-07-10 00:00:00	2024-12-08 19:01:52.831	798411719		2024-12-20 18:55:37.917
cm4fyzvi70070n10f79yqg3eu	cm4fyzvi7006rn10fhxa2v922	waiting	https://download.gerencianet.com.br/v1/275362_420_MEHMEH1/275362-3220-SERENA1/275362-3228-ENANAE5	9	25555	2025-08-10 00:00:00	2024-12-08 19:01:52.831	798411720		2024-12-20 18:55:37.917
cm4g0eo9t007jn10fo2h6uwlu	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3229-LAENA9	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:22.913	798414958		2024-12-20 18:55:37.917
cm4g0eo9t007kn10f48n8s2cd	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3230-PARAA2	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:22.913	798414959		2024-12-20 18:55:37.917
cm4g0eo9t007ln10fopq1x7fa	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3231-DRALE4	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:22.913	798414960		2024-12-20 18:55:37.917
cm4g0eo9t007mn10fa8kxoah1	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3232-MALLEO6	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:22.913	798414961		2024-12-20 18:55:37.917
cm4g0eo9t007nn10fhzmxk278	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3233-MAHI5	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:22.913	798414962		2024-12-20 18:55:37.917
cm4g0eo9t007on10fhii2ky5d	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3234-HIPA6	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:22.913	798414963		2024-12-20 18:55:37.917
cm4g0eo9t007pn10fz55jklu2	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3235-SIENA6	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:22.913	798414964		2024-12-20 18:55:37.917
cm4g0eo9t007qn10fkcz0ts7k	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3236-RAACHO7	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:22.913	798414965		2024-12-20 18:55:37.917
cm4g0eo9t007rn10fo7n2u4dn	cm4g0eo9t007in10ft5vsopyf	waiting	https://download.gerencianet.com.br/v1/275362_421_ENADO9/275362-3229-LAENA9/275362-3237-FOMAL2	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:22.913	798414966		2024-12-20 18:55:37.917
cm4g0esi00085n10fq8iij2hp	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3238-RAAFO3	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:28.392	798414970		2024-12-20 18:55:37.917
cm4g0esi00086n10fy84vhxg9	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3239-MABO4	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:28.392	798414971		2024-12-20 18:55:37.917
cm4g0esi00087n10fufvcmnjj	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3240-PACA9	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:28.392	798414972		2024-12-20 18:55:37.917
cm4g0esi00088n10fn39sfj04	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3241-PACA2	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:28.392	798414973		2024-12-20 18:55:37.917
cm4g0esi00089n10fqek58c1c	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3242-MALCA0	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:28.392	798414974		2024-12-20 18:55:37.917
cm4g0esi0008an10fkuszmmxs	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3243-RRANAE9	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:28.392	798414975		2024-12-20 18:55:37.917
cm4g0esi0008bn10fsgw8glev	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3244-HIZE7	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:28.392	798414976		2024-12-20 18:55:37.917
cm4g0esi0008cn10fdd8ujzr0	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3245-CORENA6	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:28.392	798414977		2024-12-20 18:55:37.917
cm4g0esi0008dn10fumxqfo36	cm4g0esi00084n10fl44prmeu	waiting	https://download.gerencianet.com.br/v1/275362_422_RAADA6/275362-3238-RAAFO3/275362-3246-MEHDRO6	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:28.392	798414978		2024-12-20 18:55:37.917
cm4g0ewmw008rn10f9pdge23m	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3247-DRODO8	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:33.753	798414982		2024-12-20 18:55:37.917
cm4g0ewmw008sn10fcqj9o9gm	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3248-PABRA5	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:33.753	798414983		2024-12-20 18:55:37.917
cm4g0ewmx008tn10f1kek0iog	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3249-DRALEO1	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:33.753	798414984		2024-12-20 18:55:37.917
cm4g0ewmx008un10fthbl2k7i	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3250-LOMAL6	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:33.753	798414985		2024-12-20 18:55:37.917
cm4g0ewmx008vn10fqt92ehgt	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3251-DANEM3	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:33.753	798414986		2024-12-20 18:55:37.917
cm4g0ewmx008wn10fh3hkvwcf	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3252-LEORAA9	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:33.753	798414987		2024-12-20 18:55:37.917
cm4g0ewmx008xn10f0lokw0wv	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3253-FOPA8	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:33.753	798414988		2024-12-20 18:55:37.917
cm4g0ewmx008yn10f1v9whtt6	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3254-MEHCA8	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:33.753	798414989		2024-12-20 18:55:37.917
cm4g0ewmx008zn10f10ncxwc7	cm4g0ewmw008qn10fgp1oe3qd	waiting	https://download.gerencianet.com.br/v1/275362_423_NEMRRA9/275362-3247-DRODO8/275362-3255-XINAE3	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:33.753	798414990		2024-12-20 18:55:37.917
cm4g0f083009dn10fmatwjhzl	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3256-TAFO4	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:38.403	798414995		2024-12-20 18:55:37.917
cm4g0f083009en10fbiilb7xc	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3257-SERTA3	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:38.403	798414996		2024-12-20 18:55:37.917
cm4g0f083009fn10fs4fskq71	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3258-LEOCOR0	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:38.403	798414997		2024-12-20 18:55:37.917
cm4g0f083009gn10flf5kc50x	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3259-NEMDRA9	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:38.403	798414998		2024-12-20 18:55:37.917
cm4g0f083009hn10f4py67erk	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3260-PADRO7	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:38.403	798414999		2024-12-20 18:55:37.917
cm4g0f083009in10f7qlmklr0	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3261-MALCA8	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:38.403	798415000		2024-12-20 18:55:37.917
cm4g0f083009jn10fm1hkzl98	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3262-DRARAA7	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:38.403	798415001		2024-12-20 18:55:37.917
cm4g0f083009kn10flppldcvy	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3263-HICOR6	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:38.403	798415002		2024-12-20 18:55:37.917
cm4g0f083009ln10fkb7wi7m1	cm4g0f083009cn10f0iz5vzur	waiting	https://download.gerencianet.com.br/v1/275362_424_DAMEH9/275362-3256-TAFO4/275362-3264-DROPA1	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:38.403	798415003		2024-12-20 18:55:37.917
cm4g0f4kp009zn10fkzlbpx9q	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3265-DARAA0	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:44.041	798415007		2024-12-20 18:55:37.917
cm4g0f4kp00a0n10fpvvebn27	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3266-LEOENA2	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:44.041	798415008		2024-12-20 18:55:37.917
cm4g0f4kp00a1n10f6187iwfj	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3267-XILUA6	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:44.041	798415009		2024-12-20 18:55:37.917
cm4g0f4kp00a2n10fkjahix9y	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3268-SERRAA7	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:44.041	798415010		2024-12-20 18:55:37.917
cm4g0f4kp00a3n10f5vkn0q5g	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3269-MARAA5	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:44.041	798415011		2024-12-20 18:55:37.917
cm4g0f4kp00a4n10fg3nagrin	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3270-RRASER1	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:44.041	798415012		2024-12-20 18:55:37.917
cm4g0f4kp00a5n10f1cf57ehi	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3271-NEMZE4	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:44.041	798415013		2024-12-20 18:55:37.917
cm4g0f4kp00a6n10fq83n6uoc	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3272-LEOLEO8	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:44.041	798415014		2024-12-20 18:55:37.917
cm4g0f4kp00a7n10fogq8bvzo	cm4g0f4kp009yn10fycuv4thq	waiting	https://download.gerencianet.com.br/v1/275362_425_TAFO0/275362-3265-DARAA0/275362-3273-NEMTA8	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:44.041	798415015		2024-12-20 18:55:37.917
cm4g0fah200aln10fp229amms	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3274-CHOENA0	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:51.686	798415025		2024-12-20 18:55:37.917
cm4g0fah200amn10ftc3y9n2o	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3275-LAMAL8	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:51.686	798415026		2024-12-20 18:55:37.917
cm4g0fah200ann10fi25y10ew	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3276-DADA0	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:51.686	798415027		2024-12-20 18:55:37.917
cm4g0fah200aon10fxdl70y2s	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3277-TACHO5	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:51.686	798415028		2024-12-20 18:55:37.917
cm4g0fah200apn10fb9sm60eu	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3278-BODRO5	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:51.686	798415029		2024-12-20 18:55:37.917
cm4g0fah200aqn10f4wmn4o40	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3279-MALNAE5	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:51.686	798415030		2024-12-20 18:55:37.917
cm4g0fah200arn10f1q1o05c7	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3280-RAANEM6	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:51.686	798415031		2024-12-20 18:55:37.917
cm4g0fah200asn10fxf2rnbdz	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3281-RRADO9	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:51.686	798415032		2024-12-20 18:55:37.917
cm4g0fah200atn10f01ovbfql	cm4g0fah200akn10fi3je7kjp	waiting	https://download.gerencianet.com.br/v1/275362_426_SIBRA3/275362-3274-CHOENA0/275362-3282-XILO1	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:51.686	798415033		2024-12-20 18:55:37.917
cm4g0fe4g00b7n10ftbooxaqg	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3283-CORXI0	1	25555	2024-12-10 00:00:00	2024-12-08 19:41:56.416	798415040		2024-12-20 18:55:37.917
cm4g0fe4g00b8n10fzletzhhy	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3284-LEODA5	2	25555	2025-01-10 00:00:00	2024-12-08 19:41:56.416	798415041		2024-12-20 18:55:37.917
cm4g0fe4g00b9n10f1t72xc98	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3285-LAZE2	3	25555	2025-02-10 00:00:00	2024-12-08 19:41:56.416	798415042		2024-12-20 18:55:37.917
cm4g0fe4g00ban10fmfif2ukk	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3286-CORMA6	4	25555	2025-03-10 00:00:00	2024-12-08 19:41:56.416	798415043		2024-12-20 18:55:37.917
cm4g0fe4g00bbn10fevhpvzev	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3287-MEHRRA8	5	25555	2025-04-10 00:00:00	2024-12-08 19:41:56.416	798415044		2024-12-20 18:55:37.917
cm4g0fe4g00bcn10fusubwxvk	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3288-FOLA0	6	25555	2025-05-10 00:00:00	2024-12-08 19:41:56.416	798415045		2024-12-20 18:55:37.917
cm4g0fe4g00bdn10fhezqo92e	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3289-DONEM4	7	25555	2025-06-10 00:00:00	2024-12-08 19:41:56.416	798415046		2024-12-20 18:55:37.917
cm4g0fe4g00ben10f2enkymon	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3290-RRASER5	8	25555	2025-07-10 00:00:00	2024-12-08 19:41:56.416	798415047		2024-12-20 18:55:37.917
cm4g0fe4g00bfn10fqvf2p4vt	cm4g0fe4f00b6n10f15fl1d0u	waiting	https://download.gerencianet.com.br/v1/275362_427_MALNEM7/275362-3283-CORXI0/275362-3291-TALEO7	9	25555	2025-08-10 00:00:00	2024-12-08 19:41:56.416	798415048		2024-12-20 18:55:37.917
cm4g0fhfn00btn10ffl1vr03n	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3292-ENALUA0	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:00.707	798415052		2024-12-20 18:55:37.917
cm4g0fhfn00bun10fqmzymhfk	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3293-RRACOR3	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:00.707	798415053		2024-12-20 18:55:37.917
cm4g0fhfn00bvn10f3ct2l2vu	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3294-LORRA8	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:00.707	798415054		2024-12-20 18:55:37.917
cm4g0fhfn00bwn10flejs2dpc	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3295-NEMNAE3	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:00.707	798415055		2024-12-20 18:55:37.917
cm4g0fhfn00bxn10fgrfo2wyb	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3296-LEODO3	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:00.707	798415056		2024-12-20 18:55:37.917
cm4g0fhfn00byn10fk2j74num	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3297-MEHLUA2	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:00.707	798415057		2024-12-20 18:55:37.917
cm4g0fhfn00bzn10f3ziu5jve	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3298-LEXI9	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:00.707	798415058		2024-12-20 18:55:37.917
cm4g0fhfn00c0n10f5xfqyoae	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3299-SIDO6	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:00.707	798415059		2024-12-20 18:55:37.917
cm4g0fhfn00c1n10ffjfl8ybw	cm4g0fhfn00bsn10f2d9lfx1n	waiting	https://download.gerencianet.com.br/v1/275362_428_CALA8/275362-3292-ENALUA0/275362-3300-LAXI4	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:00.707	798415060		2024-12-20 18:55:37.917
cm4g0fkz200cfn10fy47uxinh	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3301-NEMXI2	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:05.294	798415063		2024-12-20 18:55:37.917
cm4g0fkz200cgn10fv9alrnmz	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3302-SITA3	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:05.294	798415064		2024-12-20 18:55:37.917
cm4g0fkz200chn10fe91dwse3	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3303-DALE7	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:05.294	798415065		2024-12-20 18:55:37.917
cm4g0fkz200cin10fcqrn2a2g	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3304-MALLEO0	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:05.294	798415066		2024-12-20 18:55:37.917
cm4g0fkz200cjn10fxwbfsti0	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3305-ZESI1	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:05.294	798415067		2024-12-20 18:55:37.917
cm4g0fkz200ckn10f8ax71n9l	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3306-NEMBRA0	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:05.294	798415068		2024-12-20 18:55:37.917
cm4g0fkz200cln10fn3o6htya	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3307-LUASI5	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:05.294	798415069		2024-12-20 18:55:37.917
cm4g0fkz200cmn10fe042d6ay	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3308-BOCA0	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:05.294	798415070		2024-12-20 18:55:37.917
cm4g0fkz200cnn10f5qu07s9v	cm4g0fkz200cen10fo46earwg	waiting	https://download.gerencianet.com.br/v1/275362_429_SERTA0/275362-3301-NEMXI2/275362-3309-SERDA4	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:05.294	798415071		2024-12-20 18:55:37.917
cm4g0fokh00d1n10fi4thgnq0	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3310-LOCA7	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:09.952	798415078		2024-12-20 18:55:37.917
cm4g0fokh00d2n10fcrthybyx	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3311-CORCHO7	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:09.952	798415079		2024-12-20 18:55:37.917
cm4g0fokh00d3n10f5os081di	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3312-FOBO3	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:09.952	798415080		2024-12-20 18:55:37.917
cm4g0fokh00d4n10f1b7qcbbv	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3313-MALBO9	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:09.952	798415081		2024-12-20 18:55:37.917
cm4g0fokh00d5n10frvckudan	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3314-MALMA4	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:09.952	798415082		2024-12-20 18:55:37.917
cm4g0fokh00d6n10fdnvgv70g	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3315-HIRAA6	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:09.952	798415083		2024-12-20 18:55:37.917
cm4g0fokh00d7n10fcy63qxak	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3316-NEMMAL8	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:09.952	798415084		2024-12-20 18:55:37.917
cm4g0fokh00d8n10fdfwiz5e9	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3317-FODRA2	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:09.952	798415085		2024-12-20 18:55:37.917
cm4g0fokh00d9n10fj33pe5th	cm4g0fokg00d0n10fxjald70k	waiting	https://download.gerencianet.com.br/v1/275362_430_NAERRA7/275362-3310-LOCA7/275362-3318-BOPA4	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:09.952	798415086		2024-12-20 18:55:37.917
cm4g0fy1100dnn10ftfhlyter	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3319-MEHXI5	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:22.213	798415099		2024-12-20 18:55:37.917
cm4g0fy1100don10fibq4cmsj	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3320-RAADRA3	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:22.213	798415100		2024-12-20 18:55:37.917
cm4g0fy1100dpn10fz3ksu991	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3321-SIXI2	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:22.213	798415101		2024-12-20 18:55:37.917
cm4g0fy1100dqn10f3hnxfpcf	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3322-CAPA6	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:22.213	798415102		2024-12-20 18:55:37.917
cm4g0fy1100drn10fj0s5oale	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3323-HINEM7	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:22.213	798415103		2024-12-20 18:55:37.917
cm4g0fy1100dsn10fy3gd3joa	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3324-FOPA4	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:22.213	798415104		2024-12-20 18:55:37.917
cm4g0fy1100dtn10fyhbyai3h	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3325-DAXI6	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:22.213	798415105		2024-12-20 18:55:37.917
cm4g0fy1100dun10fr24gns0t	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3326-NEMBRA9	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:22.213	798415106		2024-12-20 18:55:37.917
cm4g0fy1100dvn10f5dbncao6	cm4g0fy1000dmn10f9k91pi25	waiting	https://download.gerencianet.com.br/v1/275362_431_CORLE7/275362-3319-MEHXI5/275362-3327-CASI1	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:22.213	798415107		2024-12-20 18:55:37.917
cm4g0g4k800e9n10fivexl9wr	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3328-SERNEM1	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:30.68	798415122		2024-12-20 18:55:37.917
cm4g0g4k800ean10fetyhhqki	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3329-DOLUA6	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:30.68	798415123		2024-12-20 18:55:37.917
cm4g0g4k800ebn10f409r8of4	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3330-CHOCA8	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:30.68	798415124		2024-12-20 18:55:37.917
cm4g0g4k800ecn10fy2wetel7	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3331-NAECA4	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:30.68	798415125		2024-12-20 18:55:37.917
cm4g0g4k800edn10f8n54r96r	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3332-CAFO6	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:30.68	798415126		2024-12-20 18:55:37.917
cm4g0g4k800een10fjcu199tl	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3333-ZEMEH8	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:30.68	798415127		2024-12-20 18:55:37.917
cm4g0g4k800efn10fom79rajp	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3334-CHOHI5	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:30.68	798415128		2024-12-20 18:55:37.917
cm4g0g4k800egn10f5cohph28	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3335-LAMEH6	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:30.68	798415129		2024-12-20 18:55:37.917
cm4g0g4k800ehn10fp1ixzthw	cm4g0g4k800e8n10fcuifr8q5	waiting	https://download.gerencianet.com.br/v1/275362_432_TASER7/275362-3328-SERNEM1/275362-3336-NAEDO6	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:30.68	798415130		2024-12-20 18:55:37.917
cm4g0g7tt00evn10fi7qbta01	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3337-PAMAL8	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:34.913	798415144		2024-12-20 18:55:37.917
cm4g0g7tu00ewn10fzqui9wp0	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3338-LEMAL0	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:34.913	798415145		2024-12-20 18:55:37.917
cm4g0g7tu00exn10fxonrffaf	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3339-DAPA3	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:34.913	798415146		2024-12-20 18:55:37.917
cm4g0g7tu00eyn10f3wmy4lf0	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3340-LEORRA1	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:34.913	798415147		2024-12-20 18:55:37.917
cm4g0g7tu00ezn10fg42eab5o	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3341-NEMBO3	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:34.913	798415148		2024-12-20 18:55:37.917
cm4g0g7tu00f0n10futpnhbu1	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3342-FOTA7	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:34.913	798415149		2024-12-20 18:55:37.917
cm4g0g7tu00f1n10fl7wt049y	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3343-RRATA2	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:34.913	798415150		2024-12-20 18:55:37.917
cm4g0g7tu00f2n10fts5a3b51	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3344-LEONAE7	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:34.913	798415151		2024-12-20 18:55:37.917
cm4g0g7tu00f3n10fdw50gyzc	cm4g0g7tt00eun10fr20gu3ge	waiting	https://download.gerencianet.com.br/v1/275362_433_DRALUA0/275362-3337-PAMAL8/275362-3345-LEODRA1	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:34.913	798415152		2024-12-20 18:55:37.917
cm4g0gb7900fhn10fcfguovuk	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3346-SERZE1	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:39.285	798415154		2024-12-20 18:55:37.917
cm4g0gb7900fin10fml7fiw6x	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3347-SERPA7	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:39.285	798415155		2024-12-20 18:55:37.917
cm4g0gb7900fjn10f4xh0zlh8	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3348-NEMCA1	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:39.285	798415156		2024-12-20 18:55:37.917
cm4g0gb7900fkn10f1ac73k3n	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3349-DROMA3	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:39.285	798415157		2024-12-20 18:55:37.917
cm4g0gb7900fln10fdfui3zsf	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3350-SERLEO0	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:39.285	798415158		2024-12-20 18:55:37.917
cm4g0gb7900fmn10fmn0j3sai	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3351-DRALE1	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:39.285	798415159		2024-12-20 18:55:37.917
cm4g0gb7900fnn10fwmdqcs9f	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3352-FOMA1	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:39.285	798415160		2024-12-20 18:55:37.917
cm4g0gb7900fon10fyfzj62gw	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3353-XIDRO3	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:39.285	798415161		2024-12-20 18:55:37.917
cm4g0gb7900fpn10fh6umlxmr	cm4g0gb7800fgn10fvjl4cv7m	waiting	https://download.gerencianet.com.br/v1/275362_434_BRAMEH3/275362-3346-SERZE1/275362-3354-ZETA7	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:39.285	798415162		2024-12-20 18:55:37.917
cm4g0ggfi00g3n10fgohagaim	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3355-ZEFO0	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:46.062	798415167		2024-12-20 18:55:37.917
cm4g0ggfi00g4n10fa5fuwerp	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3356-LEBRA9	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:46.062	798415168		2024-12-20 18:55:37.917
cm4g0ggfi00g5n10fgqtxsvu2	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3357-DROCA0	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:46.062	798415169		2024-12-20 18:55:37.917
cm4g0ggfi00g6n10frfbi87p5	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3358-LEORAA8	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:46.062	798415170		2024-12-20 18:55:37.917
cm4g0ggfi00g7n10fg72z4vwk	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3359-NEMTA4	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:46.062	798415171		2024-12-20 18:55:37.917
cm4g0ggfi00g8n10fiu8xtowv	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3360-NAEDA9	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:46.062	798415172		2024-12-20 18:55:37.917
cm4g0ggfj00g9n10f0e353uxb	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3361-SICA8	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:46.062	798415173		2024-12-20 18:55:37.917
cm4g0ggfj00gan10fgriseqsa	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3362-LODRO2	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:46.062	798415174		2024-12-20 18:55:37.917
cm4g0ggfj00gbn10fwnmnl41j	cm4g0ggfi00g2n10fdq9yc3nf	waiting	https://download.gerencianet.com.br/v1/275362_435_LUAMEH0/275362-3355-ZEFO0/275362-3363-FOCA1	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:46.062	798415175		2024-12-20 18:55:37.917
cm4g0gkfb00gpn10fa4gvgmir	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3364-TARRA7	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:51.239	798415183		2024-12-20 18:55:37.917
cm4g0gkfb00gqn10fiomkmfnt	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3365-TAHI0	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:51.239	798415184		2024-12-20 18:55:37.917
cm4g0gkfb00grn10fg4gjyunf	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3366-LUAZE2	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:51.239	798415185		2024-12-20 18:55:37.917
cm4g0gkfb00gsn10flxq6lmsc	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3367-RAACA3	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:51.239	798415186		2024-12-20 18:55:37.917
cm4g0gkfb00gtn10fzdg537qw	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3368-RAAMA6	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:51.239	798415187		2024-12-20 18:55:37.917
cm4g0gkfb00gun10fbks4mysf	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3369-ZECA5	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:51.239	798415188		2024-12-20 18:55:37.917
cm4g0gkfb00gvn10fr59gfcg3	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3370-XIBRA5	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:51.239	798415189		2024-12-20 18:55:37.917
cm4g0gkfb00gwn10f1r0u9es6	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3371-MACOR5	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:51.239	798415190		2024-12-20 18:55:37.917
cm4g0gkfb00gxn10fkwljfu7u	cm4g0gkfb00gon10fxzsm7bi9	waiting	https://download.gerencianet.com.br/v1/275362_436_BRAHI1/275362-3364-TARRA7/275362-3372-SIDRO6	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:51.239	798415191		2024-12-20 18:55:37.917
cm4g0go1800hbn10fy2tfko36	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3373-ZEDRO4	1	25555	2024-12-10 00:00:00	2024-12-08 19:42:55.916	798415194		2024-12-20 18:55:37.917
cm4g0go1800hcn10f72k9bsil	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3374-CASI0	2	25555	2025-01-10 00:00:00	2024-12-08 19:42:55.916	798415195		2024-12-20 18:55:37.917
cm4g0go1800hdn10foz70nez5	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3375-DRALO9	3	25555	2025-02-10 00:00:00	2024-12-08 19:42:55.916	798415196		2024-12-20 18:55:37.917
cm4g0go1800hen10fzgl9mkqs	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3376-TASER8	4	25555	2025-03-10 00:00:00	2024-12-08 19:42:55.916	798415197		2024-12-20 18:55:37.917
cm4g0go1800hfn10f6uhgc5dz	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3377-SILE3	5	25555	2025-04-10 00:00:00	2024-12-08 19:42:55.916	798415198		2024-12-20 18:55:37.917
cm4g0go1800hgn10fhhb0cotk	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3378-LANAE6	6	25555	2025-05-10 00:00:00	2024-12-08 19:42:55.916	798415199		2024-12-20 18:55:37.917
cm4g0go1800hhn10frz8daqo0	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3379-SINAE8	7	25555	2025-06-10 00:00:00	2024-12-08 19:42:55.916	798415200		2024-12-20 18:55:37.917
cm4g0go1800hin10fs1rmfz4w	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3380-LOLUA7	8	25555	2025-07-10 00:00:00	2024-12-08 19:42:55.916	798415201		2024-12-20 18:55:37.917
cm4g0go1800hjn10fznce9gi6	cm4g0go1800han10fxe93ezmv	waiting	https://download.gerencianet.com.br/v1/275362_437_CORDA2/275362-3373-ZEDRO4/275362-3381-SERDO3	9	25555	2025-08-10 00:00:00	2024-12-08 19:42:55.916	798415202		2024-12-20 18:55:37.917
cm4g0grrw00hxn10favqsp95s	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3382-LARRA7	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:00.764	798415218		2024-12-20 18:55:37.917
cm4g0grrw00hyn10fxty3g6k8	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3383-NEMZE5	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:00.764	798415219		2024-12-20 18:55:37.917
cm4g0grrw00hzn10fvw3ml4c8	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3384-DROCA6	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:00.764	798415220		2024-12-20 18:55:37.917
cm4g0grrw00i0n10fz4k1teu7	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3385-LATA3	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:00.764	798415221		2024-12-20 18:55:37.917
cm4g0grrw00i1n10fioww0gct	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3386-TAMEH8	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:00.764	798415222		2024-12-20 18:55:37.917
cm4g0grrw00i2n10fdtojwgmm	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3387-CALE6	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:00.764	798415223		2024-12-20 18:55:37.917
cm4g0grrw00i3n10fj5ifh0hp	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3388-BRARRA7	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:00.764	798415224		2024-12-20 18:55:37.917
cm4g0grrw00i4n10f20dvydnj	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3389-LEOLA8	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:00.764	798415225		2024-12-20 18:55:37.917
cm4g0grrw00i5n10fkj9quepn	cm4g0grrw00hwn10f1wdqlw84	waiting	https://download.gerencianet.com.br/v1/275362_438_NEMCA6/275362-3382-LARRA7/275362-3390-FOMEH7	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:00.764	798415226		2024-12-20 18:55:37.917
cm4g0gvlj00ijn10fnk00iluj	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3391-LEZE0	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:05.719	798415234		2024-12-20 18:55:37.917
cm4g0gvlj00ikn10f088mdh5i	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3392-PATA5	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:05.719	798415235		2024-12-20 18:55:37.917
cm4g0gvlj00iln10f33vjib40	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3393-RAACA8	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:05.719	798415236		2024-12-20 18:55:37.917
cm4g0gvlj00imn10fs32bkqqg	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3394-CORLE5	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:05.719	798415237		2024-12-20 18:55:37.917
cm4g0gvlj00inn10fgn140pvb	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3395-CANAE9	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:05.719	798415238		2024-12-20 18:55:37.917
cm4g0gvlj00ion10fdl3g73hv	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3396-CHOCA1	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:05.719	798415239		2024-12-20 18:55:37.917
cm4g0gvlj00ipn10f9t2bmmxe	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3397-MEHPA7	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:05.719	798415240		2024-12-20 18:55:37.917
cm4g0gvlj00iqn10fjulwxrf4	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3398-MAMEH6	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:05.719	798415241		2024-12-20 18:55:37.917
cm4g0gvlj00irn10fge0nb3we	cm4g0gvli00iin10fffjb70ae	waiting	https://download.gerencianet.com.br/v1/275362_439_RRADO5/275362-3391-LEZE0/275362-3399-DACA0	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:05.719	798415242		2024-12-20 18:55:37.917
cm4g0h5bx00j5n10fj8ltdlrj	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3400-LASER0	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:18.333	798415263		2024-12-20 18:55:37.917
cm4g0h5bx00j6n10fa5o9ksll	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3401-DRAZE0	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:18.333	798415264		2024-12-20 18:55:37.917
cm4g0h5bx00j7n10fzhp176ky	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3402-RAANAE6	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:18.333	798415265		2024-12-20 18:55:37.917
cm4g0h5bx00j8n10fgwthu5km	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3403-LARRA4	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:18.333	798415266		2024-12-20 18:55:37.917
cm4g0h5bx00j9n10f5o2mgbnq	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3404-PAMEH6	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:18.333	798415267		2024-12-20 18:55:37.917
cm4g0h5bx00jan10fpciu82e9	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3405-TARRA3	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:18.333	798415268		2024-12-20 18:55:37.917
cm4g0h5bx00jbn10fsfpba4vi	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3406-SERRRA0	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:18.333	798415269		2024-12-20 18:55:37.917
cm4g0h5bx00jcn10fvk6gfiih	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3407-LAMAL4	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:18.333	798415270		2024-12-20 18:55:37.917
cm4g0h5bx00jdn10ffkcv7u3j	cm4g0h5bw00j4n10fxsg2oxy2	waiting	https://download.gerencianet.com.br/v1/275362_440_PATA1/275362-3400-LASER0/275362-3408-DACA9	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:18.333	798415271		2024-12-20 18:55:37.917
cm4g0h94v00jrn10fq9dprruj	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3409-BRACOR0	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:23.263	798415276		2024-12-20 18:55:37.917
cm4g0h94v00jsn10fgb027v83	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3410-ZEXI2	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:23.263	798415277		2024-12-20 18:55:37.917
cm4g0h94v00jtn10f7r6rx7bb	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3411-SERLUA4	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:23.263	798415278		2024-12-20 18:55:37.917
cm4g0h94v00jun10f4imvsvcf	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3412-CABRA5	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:23.263	798415279		2024-12-20 18:55:37.917
cm4g0h94v00jvn10f7bldo5gu	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3413-NEMCOR1	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:23.263	798415280		2024-12-20 18:55:37.917
cm4g0h94v00jwn10fhzca6p0z	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3414-NEMNEM6	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:23.263	798415281		2024-12-20 18:55:37.917
cm4g0h94v00jxn10freuk3p56	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3415-LOMAL5	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:23.263	798415282		2024-12-20 18:55:37.917
cm4g0h94v00jyn10fil9muw6u	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3416-XILEO9	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:23.263	798415283		2024-12-20 18:55:37.917
cm4g0h94v00jzn10fa857lrh3	cm4g0h94v00jqn10f4ki0ju0w	waiting	https://download.gerencianet.com.br/v1/275362_441_CORNEM8/275362-3409-BRACOR0/275362-3417-DOSER2	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:23.263	798415284		2024-12-20 18:55:37.917
cm4g0hd0o00kdn10fb8ce3ckx	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3418-LOBRA3	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:28.295	798415289		2024-12-20 18:55:37.917
cm4g0hd0o00ken10folhxn9vy	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3419-SIRAA8	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:28.295	798415290		2024-12-20 18:55:37.917
cm4g0hd0o00kfn10feih7eyj4	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3420-TAFO7	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:28.295	798415291		2024-12-20 18:55:37.917
cm4g0hd0o00kgn10fiyo5vjnr	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3421-CHODA3	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:28.295	798415292		2024-12-20 18:55:37.917
cm4g0hd0o00khn10fqo6dw6yi	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3422-DRABO5	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:28.295	798415293		2024-12-20 18:55:37.917
cm4g0hd0o00kin10f1ffmf8v7	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3423-LEOLO3	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:28.295	798415294		2024-12-20 18:55:37.917
cm4g0hd0o00kjn10fupvec1jc	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3424-DROZE8	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:28.295	798415295		2024-12-20 18:55:37.917
cm4g0hd0o00kkn10fkupgi7gi	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3425-LUABRA2	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:28.295	798415296		2024-12-20 18:55:37.917
cm4g0hd0o00kln10fa1bmjcp5	cm4g0hd0n00kcn10f9peb1d71	waiting	https://download.gerencianet.com.br/v1/275362_442_RAASI5/275362-3418-LOBRA3/275362-3426-DRAPA6	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:28.295	798415297		2024-12-20 18:55:37.917
cm4g0hkci00kzn10f2qvmw5ng	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3427-DROENA5	1	25555	2024-12-10 00:00:00	2024-12-08 19:43:37.793	798415304		2024-12-20 18:55:37.917
cm4g0hkci00l0n10f8xa5ale9	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3428-CHORRA3	2	25555	2025-01-10 00:00:00	2024-12-08 19:43:37.793	798415305		2024-12-20 18:55:37.917
cm4g0hkci00l1n10fa9s7nya3	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3429-CABRA7	3	25555	2025-02-10 00:00:00	2024-12-08 19:43:37.793	798415306		2024-12-20 18:55:37.917
cm4g0hkci00l2n10fc2vhzwue	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3430-XIRRA3	4	25555	2025-03-10 00:00:00	2024-12-08 19:43:37.793	798415307		2024-12-20 18:55:37.917
cm4g0hkci00l3n10fxqahuji8	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3431-DORAA2	5	25555	2025-04-10 00:00:00	2024-12-08 19:43:37.793	798415308		2024-12-20 18:55:37.917
cm4g0hkci00l4n10fkdxstvuv	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3432-CORDO4	6	25555	2025-05-10 00:00:00	2024-12-08 19:43:37.793	798415309		2024-12-20 18:55:37.917
cm4g0hkci00l5n10fpzh9vbyp	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3433-XIDA6	7	25555	2025-06-10 00:00:00	2024-12-08 19:43:37.793	798415310		2024-12-20 18:55:37.917
cm4g0hkci00l6n10f2tvj40bx	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3434-PACA1	8	25555	2025-07-10 00:00:00	2024-12-08 19:43:37.793	798415311		2024-12-20 18:55:37.917
cm4g0hkci00l7n10frwjk0rwk	cm4g0hkch00kyn10feinwoyax	waiting	https://download.gerencianet.com.br/v1/275362_443_CANAE2/275362-3427-DROENA5/275362-3435-LUADRA1	9	25555	2025-08-10 00:00:00	2024-12-08 19:43:37.793	798415312		2024-12-20 18:55:37.917
cm4g0ie0g00lln10fyv4wp9el	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3436-BOSI7	1	25555	2024-12-10 00:00:00	2024-12-08 19:44:16.24	798415352		2024-12-20 18:55:37.917
cm4g0ie0g00lmn10fi7tze4ba	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3437-DROLA5	2	25555	2025-01-10 00:00:00	2024-12-08 19:44:16.24	798415353		2024-12-20 18:55:37.917
cm4g0ie0g00lnn10fchtu0cqo	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3438-NAELA4	3	25555	2025-02-10 00:00:00	2024-12-08 19:44:16.24	798415354		2024-12-20 18:55:37.917
cm4g0ie0g00lon10fc23mqn3a	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3439-DOBRA8	4	25555	2025-03-10 00:00:00	2024-12-08 19:44:16.24	798415355		2024-12-20 18:55:37.917
cm4g0ie0g00lpn10ff2rg1cc5	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3440-DRODRA0	5	25555	2025-04-10 00:00:00	2024-12-08 19:44:16.24	798415356		2024-12-20 18:55:37.917
cm4g0ie0g00lqn10fz7cg1g9s	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3441-PATA9	6	25555	2025-05-10 00:00:00	2024-12-08 19:44:16.24	798415357		2024-12-20 18:55:37.917
cm4g0ie0g00lrn10fxc1bwyfr	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3442-CABO5	7	25555	2025-06-10 00:00:00	2024-12-08 19:44:16.24	798415358		2024-12-20 18:55:37.917
cm4g0ie0g00lsn10fgj3kkwcf	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3443-DROLO6	8	25555	2025-07-10 00:00:00	2024-12-08 19:44:16.24	798415359		2024-12-20 18:55:37.917
cm4g0ie0g00ltn10frww6495e	cm4g0ie0g00lkn10f72m3sna7	waiting	https://download.gerencianet.com.br/v1/275362_444_SISER9/275362-3436-BOSI7/275362-3444-HIMA1	9	25555	2025-08-10 00:00:00	2024-12-08 19:44:16.24	798415360		2024-12-20 18:55:37.917
cm4g0ik8z00m7n10fi4xqovco	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3445-LOCA0	1	25555	2024-12-10 00:00:00	2024-12-08 19:44:24.323	798415376		2024-12-20 18:55:37.917
cm4g0ik8z00m8n10f6ni5ti8v	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3446-LEXI9	2	25555	2025-01-10 00:00:00	2024-12-08 19:44:24.323	798415377		2024-12-20 18:55:37.917
cm4g0ik8z00m9n10fzu3h7k1v	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3447-DOCA3	3	25555	2025-02-10 00:00:00	2024-12-08 19:44:24.323	798415378		2024-12-20 18:55:37.917
cm4g0ik8z00man10fkrwahqx0	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3448-LASER8	4	25555	2025-03-10 00:00:00	2024-12-08 19:44:24.323	798415379		2024-12-20 18:55:37.917
cm4g0ik8z00mbn10fd8ksr6zi	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3449-ENAMAL8	5	25555	2025-04-10 00:00:00	2024-12-08 19:44:24.323	798415380		2024-12-20 18:55:37.917
cm4g0ik8z00mcn10fak6pw7wl	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3450-TALO5	6	25555	2025-05-10 00:00:00	2024-12-08 19:44:24.323	798415381		2024-12-20 18:55:37.917
cm4g0ik8z00mdn10f5q8et5pj	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3451-RRAMA2	7	25555	2025-06-10 00:00:00	2024-12-08 19:44:24.323	798415382		2024-12-20 18:55:37.917
cm4g0ik8z00men10ftlj5fswh	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3452-MALRRA5	8	25555	2025-07-10 00:00:00	2024-12-08 19:44:24.323	798415383		2024-12-20 18:55:37.917
cm4g0ik8z00mfn10fm7csfiin	cm4g0ik8y00m6n10fsqs3mm4p	waiting	https://download.gerencianet.com.br/v1/275362_445_XIRRA0/275362-3445-LOCA0/275362-3453-LEHI2	9	25555	2025-08-10 00:00:00	2024-12-08 19:44:24.323	798415384		2024-12-20 18:55:37.917
cm4g0iq9100mtn10fjly8u7g6	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3454-BRALA7	1	25555	2024-12-10 00:00:00	2024-12-08 19:44:32.101	798415389		2024-12-20 18:55:37.917
cm4g0iq9100mun10fsaq8r0ef	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3455-ENARRA3	2	25555	2025-01-10 00:00:00	2024-12-08 19:44:32.101	798415390		2024-12-20 18:55:37.917
cm4g0iq9100mvn10f1i3jvh54	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3456-SILUA7	3	25555	2025-02-10 00:00:00	2024-12-08 19:44:32.101	798415391		2024-12-20 18:55:37.917
cm4g0iq9100mwn10f4vx6xkl2	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3457-LALO9	4	25555	2025-03-10 00:00:00	2024-12-08 19:44:32.101	798415392		2024-12-20 18:55:37.917
cm4g0iq9100mxn10fxnh7fg0j	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3458-SINEM6	5	25555	2025-04-10 00:00:00	2024-12-08 19:44:32.101	798415393		2024-12-20 18:55:37.917
cm4g0iq9100myn10fg864uzpg	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3459-HIDO5	6	25555	2025-05-10 00:00:00	2024-12-08 19:44:32.101	798415394		2024-12-20 18:55:37.917
cm4g0iq9100mzn10f93yhtf7d	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3460-HIXI3	7	25555	2025-06-10 00:00:00	2024-12-08 19:44:32.101	798415395		2024-12-20 18:55:37.917
cm4g0iq9100n0n10f4910eeqa	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3461-SIDO9	8	25555	2025-07-10 00:00:00	2024-12-08 19:44:32.101	798415396		2024-12-20 18:55:37.917
cm4g0iq9100n1n10f3d486k9s	cm4g0iq9000msn10fwidd2955	waiting	https://download.gerencianet.com.br/v1/275362_446_LUASER4/275362-3454-BRALA7/275362-3462-CHODO6	9	25555	2025-08-10 00:00:00	2024-12-08 19:44:32.101	798415397		2024-12-20 18:55:37.917
cm4g0j6xy00nfn10fvbddut7z	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3463-BORRA4	1	25555	2024-12-10 00:00:00	2024-12-08 19:44:53.734	798415428		2024-12-20 18:55:37.917
cm4g0j6xy00ngn10fi1dyoki1	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3464-MALENA8	2	25555	2025-01-10 00:00:00	2024-12-08 19:44:53.734	798415429		2024-12-20 18:55:37.917
cm4g0j6xy00nhn10f6sy6b2c7	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3465-SIPA7	3	25555	2025-02-10 00:00:00	2024-12-08 19:44:53.734	798415430		2024-12-20 18:55:37.917
cm4g0j6xy00nin10fwx614gm4	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3466-NEMCHO8	4	25555	2025-03-10 00:00:00	2024-12-08 19:44:53.734	798415431		2024-12-20 18:55:37.917
cm4g0j6xy00njn10fs7wnfh1a	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3467-MARAA4	5	25555	2025-04-10 00:00:00	2024-12-08 19:44:53.734	798415432		2024-12-20 18:55:37.917
cm4g0j6xy00nkn10fzroyr1oe	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3468-CHODRA3	6	25555	2025-05-10 00:00:00	2024-12-08 19:44:53.734	798415433		2024-12-20 18:55:37.917
cm4g0j6xy00nln10fxby6k3p7	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3469-CHOENA5	7	25555	2025-06-10 00:00:00	2024-12-08 19:44:53.734	798415434		2024-12-20 18:55:37.917
cm4g0j6xy00nmn10f9x8rfdv5	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3470-LUALA1	8	25555	2025-07-10 00:00:00	2024-12-08 19:44:53.734	798415435		2024-12-20 18:55:37.917
cm4g0j6xy00nnn10f27eh8mui	cm4g0j6xy00nen10f7g7wm92k	waiting	https://download.gerencianet.com.br/v1/275362_447_CASI6/275362-3463-BORRA4/275362-3471-MARRA9	9	25555	2025-08-10 00:00:00	2024-12-08 19:44:53.734	798415436		2024-12-20 18:55:37.917
cm4g0jau500o1n10f2y29saqk	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3472-LOLO3	1	25555	2024-12-10 00:00:00	2024-12-08 19:44:58.78	798415441		2024-12-20 18:55:37.917
cm4g0jau500o2n10fwcvkpkhl	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3473-TAENA2	2	25555	2025-01-10 00:00:00	2024-12-08 19:44:58.78	798415442		2024-12-20 18:55:37.917
cm4g0jau500o3n10fqf4g2kos	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3474-ZEPA9	3	25555	2025-02-10 00:00:00	2024-12-08 19:44:58.78	798415443		2024-12-20 18:55:37.917
cm4g0jau500o4n10f4ytf23v4	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3475-CALE9	4	25555	2025-03-10 00:00:00	2024-12-08 19:44:58.78	798415444		2024-12-20 18:55:37.917
cm4g0jau500o5n10fd5owl3yq	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3476-SISER4	5	25555	2025-04-10 00:00:00	2024-12-08 19:44:58.78	798415445		2024-12-20 18:55:37.917
cm4g0jau500o6n10f2c8jj2cn	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3477-LUALEO9	6	25555	2025-05-10 00:00:00	2024-12-08 19:44:58.78	798415446		2024-12-20 18:55:37.917
cm4g0jau500o7n10f9c9vyoqe	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3478-CHOCOR2	7	25555	2025-06-10 00:00:00	2024-12-08 19:44:58.78	798415447		2024-12-20 18:55:37.917
cm4g0jau500o8n10f3eebvoxl	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3479-PANEM3	8	25555	2025-07-10 00:00:00	2024-12-08 19:44:58.78	798415448		2024-12-20 18:55:37.917
cm4g0jau500o9n10f2jyu43p6	cm4g0jau400o0n10f3ixydz7n	waiting	https://download.gerencianet.com.br/v1/275362_448_LUADO7/275362-3472-LOLO3/275362-3480-NAERAA9	9	25555	2025-08-10 00:00:00	2024-12-08 19:44:58.78	798415449		2024-12-20 18:55:37.917
cm4g0jfsk00onn10fey1yhj5e	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3481-LACA1	1	25555	2024-12-10 00:00:00	2024-12-08 19:45:05.204	798415453		2024-12-20 18:55:37.917
cm4g0jfsk00oon10f218wd2ug	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3482-LUARRA2	2	25555	2025-01-10 00:00:00	2024-12-08 19:45:05.204	798415454		2024-12-20 18:55:37.917
cm4g0jfsk00opn10f0i391qlv	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3483-LEOHI5	3	25555	2025-02-10 00:00:00	2024-12-08 19:45:05.204	798415455		2024-12-20 18:55:37.917
cm4g0jfsk00oqn10fhjo18y6h	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3484-CORBRA1	4	25555	2025-03-10 00:00:00	2024-12-08 19:45:05.204	798415456		2024-12-20 18:55:37.917
cm4g0jfsk00orn10fgtegtwo2	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3485-RRASER2	5	25555	2025-04-10 00:00:00	2024-12-08 19:45:05.204	798415457		2024-12-20 18:55:37.917
cm4g0jfsk00osn10f46dhpgvm	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3486-MALCOR6	6	25555	2025-05-10 00:00:00	2024-12-08 19:45:05.204	798415458		2024-12-20 18:55:37.917
cm4g0jfsk00otn10fwmjc2kes	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3487-BRAENA4	7	25555	2025-06-10 00:00:00	2024-12-08 19:45:05.204	798415459		2024-12-20 18:55:37.917
cm4g0jfsk00oun10fcblk9lyz	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3488-TALEO8	8	25555	2025-07-10 00:00:00	2024-12-08 19:45:05.204	798415460		2024-12-20 18:55:37.917
cm4g0jfsk00ovn10f9r34jbbo	cm4g0jfsk00omn10f2tfjycon	waiting	https://download.gerencianet.com.br/v1/275362_449_NEMPA1/275362-3481-LACA1/275362-3489-CABRA8	9	25555	2025-08-10 00:00:00	2024-12-08 19:45:05.204	798415461		2024-12-20 18:55:37.917
cm4g0jl7q00p9n10f1dxsmssw	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3490-TABRA0	1	25555	2024-12-10 00:00:00	2024-12-08 19:45:12.23	798415467		2024-12-20 18:55:37.917
cm4g0jl7q00pan10fl8udvpez	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3491-SERRAA1	2	25555	2025-01-10 00:00:00	2024-12-08 19:45:12.23	798415468		2024-12-20 18:55:37.917
cm4g0jl7q00pbn10f5xbsaelm	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3492-NEMMA0	3	25555	2025-02-10 00:00:00	2024-12-08 19:45:12.23	798415469		2024-12-20 18:55:37.917
cm4g0jl7q00pcn10fawnjzqy2	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3493-LADA6	4	25555	2025-03-10 00:00:00	2024-12-08 19:45:12.23	798415470		2024-12-20 18:55:37.917
cm4g0jl7q00pdn10ftib952fu	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3494-MACOR3	5	25555	2025-04-10 00:00:00	2024-12-08 19:45:12.23	798415471		2024-12-20 18:55:37.917
cm4g0jl7q00pen10feieirqem	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3495-LOSI7	6	25555	2025-05-10 00:00:00	2024-12-08 19:45:12.23	798415472		2024-12-20 18:55:37.917
cm4g0jl7r00pfn10fuguix1ty	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3496-SERNEM6	7	25555	2025-06-10 00:00:00	2024-12-08 19:45:12.23	798415473		2024-12-20 18:55:37.917
cm4g0jl7r00pgn10fc1mra23h	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3497-CHOBRA3	8	25555	2025-07-10 00:00:00	2024-12-08 19:45:12.23	798415474		2024-12-20 18:55:37.917
cm4g0jl7r00phn10f8wzbdh3a	cm4g0jl7q00p8n10fyn308bxz	waiting	https://download.gerencianet.com.br/v1/275362_450_DRALEO2/275362-3490-TABRA0/275362-3498-RAALO1	9	25555	2025-08-10 00:00:00	2024-12-08 19:45:12.23	798415475		2024-12-20 18:55:37.917
cm4g0jor000pvn10f19m5lmb6	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3499-RAADO1	1	25555	2024-12-10 00:00:00	2024-12-08 19:45:16.812	798415494		2024-12-20 18:55:37.917
cm4g0jor000pwn10fyl6le5o3	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3500-ENACA4	2	25555	2025-01-10 00:00:00	2024-12-08 19:45:16.812	798415495		2024-12-20 18:55:37.917
cm4g0jor000pxn10fh32dy5hi	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3501-DODA4	3	25555	2025-02-10 00:00:00	2024-12-08 19:45:16.812	798415496		2024-12-20 18:55:37.917
cm4g0jor000pyn10fwxpn492d	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3502-BOHI8	4	25555	2025-03-10 00:00:00	2024-12-08 19:45:16.812	798415497		2024-12-20 18:55:37.917
cm4g0jor000pzn10f4hylncw2	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3503-CANAE2	5	25555	2025-04-10 00:00:00	2024-12-08 19:45:16.812	798415498		2024-12-20 18:55:37.917
cm4g0jor000q0n10f4yvh4jrx	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3504-LODA1	6	25555	2025-05-10 00:00:00	2024-12-08 19:45:16.812	798415499		2024-12-20 18:55:37.917
cm4g0jor000q1n10f70rh7tdv	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3505-DADA5	7	25555	2025-06-10 00:00:00	2024-12-08 19:45:16.812	798415500		2024-12-20 18:55:37.917
cm4g0jor000q2n10f8kcatyvp	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3506-SISER8	8	25555	2025-07-10 00:00:00	2024-12-08 19:45:16.812	798415501		2024-12-20 18:55:37.917
cm4g0jor000q3n10fck6tssje	cm4g0joqz00pun10fhs8ekokv	waiting	https://download.gerencianet.com.br/v1/275362_451_LOMA0/275362-3499-RAADO1/275362-3507-NAEBRA8	9	25555	2025-08-10 00:00:00	2024-12-08 19:45:16.812	798415502		2024-12-20 18:55:37.917
cm4g7xyeb00r5n10fq9lf93xn	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3508-BOLEO2	1	25555	2024-12-10 00:00:00	2024-12-08 23:12:19.783	798430575		2024-12-20 18:55:37.917
cm4g7xyec00r6n10fjzjldwwp	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3509-LELO1	2	25555	2025-01-10 00:00:00	2024-12-08 23:12:19.783	798430576		2024-12-20 18:55:37.917
cm4g7xyec00r7n10f1zeb0flw	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3510-RAADO2	3	25555	2025-02-10 00:00:00	2024-12-08 23:12:19.783	798430577		2024-12-20 18:55:37.917
cm4g7xyec00r8n10fefegl7ze	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3511-SERCA4	4	25555	2025-03-10 00:00:00	2024-12-08 23:12:19.783	798430578		2024-12-20 18:55:37.917
cm4g7xyec00r9n10f37kitoe4	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3512-MACOR4	5	25555	2025-04-10 00:00:00	2024-12-08 23:12:19.783	798430579		2024-12-20 18:55:37.917
cm4g7xyec00ran10fzdbfljwy	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3513-XICA3	6	25555	2025-05-10 00:00:00	2024-12-08 23:12:19.783	798430580		2024-12-20 18:55:37.917
cm4g7xyec00rbn10frbc1r0pr	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3514-DRASI2	7	25555	2025-06-10 00:00:00	2024-12-08 23:12:19.783	798430581		2024-12-20 18:55:37.917
cm4g7xyec00rcn10f2nrzzmdv	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3515-SIDA9	8	25555	2025-07-10 00:00:00	2024-12-08 23:12:19.783	798430582		2024-12-20 18:55:37.917
cm4g7xyec00rdn10fmccc29t2	cm4g7xye000r4n10fvtr9g8m4	waiting	https://download.gerencianet.com.br/v1/275362_452_MALLO3/275362-3508-BOLEO2/275362-3516-LEOTA5	9	25555	2025-08-10 00:00:00	2024-12-08 23:12:19.783	798430583		2024-12-20 18:55:37.917
cm4k688b10002my0fb0kp9ax2	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3517-RRALO9	1	25555	2024-12-15 00:00:00	2024-12-11 17:35:24.686	800676204		2024-12-20 18:55:37.917
cm4k688b10003my0fxjz645qb	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3518-BOCA9	2	25555	2025-01-15 00:00:00	2024-12-11 17:35:24.686	800676205		2024-12-20 18:55:37.917
cm4k688b10004my0fro73eabo	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3519-FOMEH9	3	25555	2025-02-15 00:00:00	2024-12-11 17:35:24.686	800676206		2024-12-20 18:55:37.917
cm4k688b10005my0fhb34f6ri	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3520-DODA6	4	25555	2025-03-15 00:00:00	2024-12-11 17:35:24.686	800676207		2024-12-20 18:55:37.917
cm4k688b10006my0fo1gv4yvu	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3521-DOHI5	5	25555	2025-04-15 00:00:00	2024-12-11 17:35:24.686	800676208		2024-12-20 18:55:37.917
cm4k688b10007my0fn48wqc2v	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3522-FOMEH7	6	25555	2025-05-15 00:00:00	2024-12-11 17:35:24.686	800676209		2024-12-20 18:55:37.917
cm4k688b10008my0f4u2fh63k	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3523-LUACOR0	7	25555	2025-06-15 00:00:00	2024-12-11 17:35:24.686	800676210		2024-12-20 18:55:37.917
cm4k688b20009my0frm5swing	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3524-DOHI1	8	25555	2025-07-15 00:00:00	2024-12-11 17:35:24.686	800676211		2024-12-20 18:55:37.917
cm4k688b2000amy0f1uxkim37	cm4k688b10001my0f1yzql4pc	waiting	https://download.gerencianet.com.br/v1/275362_453_SILUA3/275362-3517-RRALO9/275362-3525-SERLO5	9	25555	2025-08-15 00:00:00	2024-12-11 17:35:24.686	800676212		2024-12-20 18:55:37.917
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customer" (id, name, cpf, "birthDate", phone, email, address, "postalCode", "spouseName", "carnetGenerated", "userId", "createdAt", "updatedAt", status) FROM stdin;
cm4cvtyma004so70fdj2ifl47	Auridéia Coelho Pires 	02224076480	1970-01-01 00:00:31.321	86 99953-2173	aurideiapires@hotmail.com	 Rua Adão Medeiros Soares 475, Bloco 5 Ap: 305 Bairro: Novo Horizonte 	64080-105	Airton da Costa Oliveira Júnior	f	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.553	2024-12-06 15:09:59.553	WAITING_LIST
cm4cvtynw005oo70f5s9g9mpm	Gerria Rodrigues da Silva 	99839702310	1970-01-01 00:00:30.284	86988119567	Gerria32@gmail.com	Rua nelson cruz 	64005640	Celso Rodrigues da silva 	f	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.612	2024-12-06 15:09:59.612	WAITING_LIST
cm4cvtykw004io70f7so7gzyk	Ana Luiza Gomes Martins	03052242393	1970-01-01 00:00:31.729	86994889708	analuizagomesmartins@hotmail.com	Quadra 50, casa 39, Residencial Geanete Morais Sousa, Renascença 2	64082130	Carlos Felipe Lima Primo	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.503	2024-12-20 20:21:33.682	CONFIRMED
cm4cvtylv004ko70fikxbnvlu	ANTONIA EMANUELLE DE MORAIS ALVES	06010114306	1970-01-01 00:00:35.06	86994687499	THIAGOPORTELLAK1@GMAIL.COM	RUA FIRMINO DE SOUSA MARTINS 2125 PARQUE IDEAL	64078690	THIAGO PORTELA DE OLIVEIRA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.538	2024-12-20 20:21:41.323	CONFIRMED
cm4cvtylz004mo70fq5d8t8d6	Antonio Jose Ferreira	73044091349	1970-01-01 00:00:28.583	86 98881- 8801	antoniojferreira2013@gmail.com	Rua Paulo Carneiro da Cunha, 2602, bloco 13 APT 202, Tancredo Neves	64076-030	Julianne Celestino dos Santos Costa	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.542	2024-12-20 20:21:59.544	CONFIRMED
cm4cvtym2004oo70ffepq8m5f	Antonio Marcos Carvalho	01216502358	1970-01-01 00:00:31.211	86994843376	antoniomarcosc706@gmail.com	Rua São Raimundo 2087	64088620	Valquirene Vasconcelos da Silva Cunha	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.546	2024-12-20 20:22:53.296	CONFIRMED
cm4cvtym7004qo70fka8gvuta	Arlania Martins Gomes Araujo	05741090303	1970-01-01 00:00:34.768	86 994440768	arlania-enef@hotmail.com	Rua Professora Aldaneiva, 4507 Novo Horizonte	64079040	Itallo Rossi Araujo Nascimento	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.549	2024-12-20 20:23:04.84	CONFIRMED
cm4cvtymd004uo70fkpe6hk94	Aurifran da Costa Sousa 	00115085319	1970-01-01 00:00:30.527	86998487443	aurifrancs@gmail.com	rua professor Alda Neiva 4912 	\N	Ana Lucia Ribeiro Oliveira Sousa 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.556	2024-12-20 20:23:50.558	CONFIRMED
cm4cvtymj004wo70f6c5zwss4	Brendo de Melo Pereira	05106386357	1970-01-01 00:00:35.269	86999341071	brendo.farmajf@gmail.com	Alameda dos Sabiás, 940, Condomínio Reserva dos Sabiás 2, casa 123	64093040	Juliana Silva Cavalcante Pereira	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.561	2024-12-20 20:25:58.594	CONFIRMED
cm4cvtymt0052o70f49x7l7xv	Cleide Cristina Rodrigues Holanda	39646181368	1970-01-01 00:00:28.392	86 994791527	cleidecristinaholanda@gmail.com	 Rua Jose Evangelista de Sousa, 5238 Bl 11 apto101	64079063	Francisco Wilson Cardoso Araujo	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.572	2024-12-20 20:26:05.6	CONFIRMED
cm4cvtymx0054o70fdcx42t4n	Daniela Barbosa Silva 	04487201322	1970-01-01 00:00:34.796	86988105307	danniibar@gmail.com	Rua Cerejeira 4555	64022245	Hely Anderson Soares de Melo 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.576	2024-12-20 20:26:08.309	CONFIRMED
cm4cvtyn20056o70feiuckp6a	Deljames Nascimento	06873662321	1970-01-01 00:00:36.004	86995118557	deljames_@hotmail.com	Quadra E, casa 23, Loteamento Vitória	64091600	Stephany Maria Alvez Dionizio	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.581	2024-12-20 20:26:11.6	CONFIRMED
cm4cvtyn60058o70fxdgc0pby	Denise Gomes Martins	00009810366	1970-01-01 00:00:29.857	86 995655133	denisegomes.adm@gmail.com	Residencial Jeanete Moraes Q50 C39 Renascença 2	64082130	Roberto Borges Araujo	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.586	2024-12-20 20:26:13.552	CONFIRMED
cm4cvtyn9005ao70fwqx6tfp1	ERICA MARIA ALVES MENDONÇA	07039325357	1970-01-01 00:00:35.815	86994422339	ERICAMAMENDONCA@GMAIL.COM	COND TERRAZO POTI BL 11 APT 204	64091410	ARTUR FELIPE DA SILVA VELOSO	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.589	2024-12-20 20:27:32.95	CONFIRMED
cm4cvtynd005co70farq0qf3r	Erik Bruno Pires Alves	07770015359	1970-01-01 00:00:37.925	86998069380	erikbruno3110@gmail.com	Quadra 56, casa 11	64077170	Maria Eduarda Sampaio Cavalcante Pires	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.592	2024-12-20 20:27:45.404	CONFIRMED
cm4cvtyng005eo70ffo06be87	Erivelton Gomes de Sousa	74926330334	1970-01-01 00:00:28.143	8698825-9576	eriveltonsousa500@hotmail.com	Quadra C, casa 27	64079-079	Rosimeire Alves de Alencar Sousa	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.595	2024-12-20 20:27:46.909	CONFIRMED
cm4cvtynj005go70fjgp2xesz	Francisca Rodrigues de Sousa Brito	00515346306	1970-01-01 00:00:30.262	86 998252418	kinha.r.sousa@hotmail.com	Av. Prof Camilo Filho, 5244 Bairro Verdecap	64093020	George Alves Brito	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.598	2024-12-20 20:27:53.342	CONFIRMED
cm4cvtynm005io70f44qfolo7	Francisco Carlos de Oliveira Lima	05244831321	1970-01-01 00:00:34.416	86988193243	27fra32.carlos@gmail.com	Quadra 2 casa 25 Renascença 1	\N	Marbara Luana Machado Almeida	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.601	2024-12-20 20:27:55.853	CONFIRMED
cm4cvtynp005ko70ficnqtndz	Francisco das Chagas de Oliveira Lopes	49026402368	1970-01-01 00:00:26.218	86999468646	timonturismo@gmail.com	Rua Anselmo Peretti 2836	64078680	Francisca das Chagas Soares de Oliveira Lopes	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.604	2024-12-20 20:27:58.094	CONFIRMED
cm4cvtyns005mo70f9erx8zuv	Francisco das Chagas Silva Resende	05576969332	1970-01-01 00:00:34.137	86998488989	\N	Condomínio Lenita Ferreira, Ap 204	64093020	Alane Barbosa de Sousa Resende	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.607	2024-12-20 20:28:02.209	CONFIRMED
cm4cvtynz005qo70f98frzmsm	Glaucia de Oliveira Costa Campos	06036032382	1970-01-01 00:00:34.049	86 98112-4825	costaglaucia805@gmail.com	Rua 20, quadra 17, casa 18,Residencial Frei Damião	64090-490	Antonio Jeferson Campos da Silva	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.615	2024-12-20 20:28:04.18	CONFIRMED
cm4cvtyo6005uo70fy2i9cu8a	Helison Ribeiro Nascimento 	03819193316	1970-01-01 00:00:33.507	86999277902	helison126@gmail.com	Rua Dr. Pedro Teixeira 2930/1	64077785	Vanessa Soares Lopes	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.621	2024-12-20 20:28:11.084	CONFIRMED
cm4cvtyod005yo70f2dz7ovws	Hinton Correia Magalhães Junior	65575628353	1970-01-01 00:00:29.736	86 998468469	hintonjunior2012@gmail.com	Rua Adão Medeiros Soares, 3918 Casa	64075105	Franciane Costa Reis Magalhães	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.628	2024-12-20 20:28:13.743	CONFIRMED
cm4cvtyog0060o70f0494okjo	Iraildes Sousa Abreu	70444331387	1970-01-01 00:00:27.335	86 988128928	iraildes_spfc@hotmail.com	Av Prof Camilo Filho, 5633 Characa Rosana	64093020	Jose Alberto Gomes Nascimento	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.631	2024-12-20 20:28:14.898	CONFIRMED
cm4cvtyok0062o70fqa81zigf	IRIS PONTES DA SILVA SOUSA	87468034320	1970-01-01 00:00:26.889	86995632763	IRISPONTES13@GMAIL.COM	QD 239 CASA 19 DIRCEU 2	\N	ANTONIO FRANCISCO DE SOUSA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.635	2024-12-20 20:28:15.998	CONFIRMED
cm4cvtyqu007io70fwexe3oxm	Muriel de Santana Dias	06748978386	1970-01-01 00:00:34.93	86 995698912	santannamuriel@gmail.com	Rua Chancele Edson de Queiroz, 1995	64077750	Rute Silva Rodrigues Santana	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.718	2024-12-20 20:29:20.669	CONFIRMED
cm4cvtyks004go70f2jyrigmz	Allysson Keslly Neves dos Santos 	06619174361	1970-01-01 00:00:36.839	86994348289	allyssonkeslley22@gmail.com	Rua onze, Novo Horizonte, Lot.Manuel evangelista 	64079157	Geane Viana Ribeiro	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.499	2024-12-20 20:17:55.706	CONFIRMED
cm4cvtyow006ao70fl2wgfode	Josué Davi Alves Oliveira	06880589308	1970-01-01 00:00:38.415	86994390318	josuealves7896@gmail.com	Quadra 42, casa 12	64077118	Amanda Barbosa de Sousa	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.647	2024-12-20 20:28:32.604	CONFIRMED
cm4cvtyoz006co70fe5vjxony	JULYENE CARDOSO MATOS	03734270340	1970-01-01 00:00:33.424	8699563788	JULYENE450@GMAIL.COM	QD 59 CASA 10 DIRCEU I	64077180	HEWERTTON THIAGO DA SILVA MATOS	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.651	2024-12-20 20:28:34.87	CONFIRMED
cm4cvtyp2006eo70ftygr49d9	KATIA MARIA DE ARAUJO SOARES	66092078368	1970-01-01 00:00:25.113	86994867172	KATIAEDILSONF2@GMAIL.COM	Q64 CASA 04B RENACENÇA 2	\N	EDILSON SOARES DE OLIVEIRA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.654	2024-12-20 20:28:36.182	CONFIRMED
cm4cvtyp5006go70f71apq0wb	KATIENE VALERIA DE ARAUJO 	03125878306	1970-01-01 00:00:32.076	86999707294	KATIENEVALERIAA@GMAIL.COM	Q 64 CASA 04	\N	JOSE RODRIGUES CARDOSO NETO	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.657	2024-12-20 20:28:37.612	CONFIRMED
cm4cvtyp8006io70f9mcycv8w	Kleber Alves de Sousa	01027012370	1970-01-01 00:00:31.425	86994395400	kllebeer134alves@gmail.com	Quadra 31, casa 45, Frei Damião	64090305	Irislane Soares Rodrigues Alves	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.66	2024-12-20 20:28:39.313	CONFIRMED
cm4cvtypc006ko70f5s1rjz2w	LAIZE PINHO MACHADO VIEIRA	04963986361	1970-01-01 00:00:33.079	86999491928	LAIZEMACHADOVIEIRA@GMAIL.COM	RUA ESMERALDA 162 BAIRRO JOIA - TIMON	65632290	ANTONIO JOSE VIEIRA NETO	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.663	2024-12-20 20:28:40.625	CONFIRMED
cm4cvtype006mo70fq9eia0sb	Leila Otaviana Tavares dos Santos Silva 	03966649381	1970-01-01 00:00:30.363	99 98420-3509	leilatimoteo225@gail.com	Rua Tiradentes, Bairro marquê,1932.	640025-005	Édem Timóteo da Silva	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.666	2024-12-20 20:28:42.971	CONFIRMED
cm4cvtypi006oo70fhhnfg07r	Lídia Sabia Lima	02619594332	1970-01-01 00:00:32.404	(86)994922923	lidiasaboia79@gmail.com	Rua Colombo 3006, bela vista 	64031207	José Alves de Lima 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.669	2024-12-20 20:28:44.575	CONFIRMED
cm4cvtypl006qo70fly5toiid	Lucas Castelo Branco de Sousa	05701444341	1970-01-01 00:00:33.64	86998029020	pastorlucascastelo@icloud.com	Alameda dos Sabiás, 940, Condomínio Reserva dos Sabiás 2, casa 102	64093040	Erica Raissa Castelo Branco Miranda	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.673	2024-12-20 20:28:49.262	CONFIRMED
cm4cvtypp006so70f6bbuxzgv	Lucas Oliveira Nascimento 	03261903333	1970-01-01 00:00:34.492	86981921567	Lucas.oliveira_1994@outlook.com	Rua Simon Bolivar, 3051	64078065	Nathalia Heinrich Nascimento 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.676	2024-12-20 20:28:50.606	CONFIRMED
cm4cvtypr006uo70f8iegzpz4	LUIS FELIPE SOUSA VASCONCELOS	05684254306	1970-01-01 00:00:34.337	86981327124	PHELLIPEV61@GMAIL.COM	VILA WASHINGTON FEITOSA, QD A CASA 04	64085100	JOELINA DE OLIVEIRA VASCONCELOS	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.679	2024-12-20 20:28:51.954	CONFIRMED
cm4cvtypv006wo70f8mybl6tl	Mara Beatriz da Silva Carvalho	06999343381	1970-01-01 00:00:35.586	86999541565	marabc929@gmail.com	Alphaville Leste	64006130	André de Jesus Carvalho	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.682	2024-12-20 20:28:53.195	CONFIRMED
cm4cvtypy006yo70f25u1ss1v	MARCELA SOUSA CAMPOS NOVAIS	02979611360	1970-01-01 00:00:30.638	86988040090	AILTON.NOVAIS142@GMAIL.COM	64078261	\N	AILTON DA SILVA NOVAIS	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.685	2024-12-20 20:28:54.854	CONFIRMED
cm4cvtyq10070o70fcutji2vx	Marcio de Araujo Silva	94917930391	1970-01-01 00:00:30.411	86 998458703	marcio0504@gmail.com	Rua Manoel Ildefonso Limas, 2929 Parque Ideal	64078730	Nailiana da Silva Monte	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.688	2024-12-20 20:28:56.218	CONFIRMED
cm4cvtyq50072o70fnxhe6isu	Marcos Teodoro Monteiro 	90816404372	1970-01-01 00:00:29.46	86 988231302	marcosteodoro736@gmail.com	Rua Santa Luzia 780	64090430	Cristiane Lustosa de Almeida Monteiro 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.692	2024-12-20 20:28:57.469	CONFIRMED
cm4cvtyqb0076o70fng23gq5f	Maria Da Guia Sousa Dourado	00760643369	1970-01-01 00:00:27.824	86 988048830	guiasnt76@gmail.com	Q 68 C02 Bairro Dirceu 1	64077210	Antonio Carlos de Oliveira	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.698	2024-12-20 20:29:02.132	CONFIRMED
cm4cvtyqe0078o70ft6z9r18y	MARIA RITA DOS PRAZERES LIMA CAMPOS	09687090367	1970-01-01 00:00:38.516	86988191446	mrdplc15@gmail.com	Q51C1A RENASCENÇA2	64082550	THIAGO LIMA COSTA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.701	2024-12-20 20:29:11.952	CONFIRMED
cm4cvtyqh007ao70fo84qfzfd	Marla Larissa Saraiva Silva Viana 	06141154344	1970-01-01 00:00:34.776	86- 995945576	marlla.vmachado@gmail.com	Quadra Y casa 01 Residencial Araguai 	6485-050	Gerson Viana Ribeiro	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.704	2024-12-20 20:29:14.169	CONFIRMED
cm4cvtyqk007co70f6gbykqhg	Mávia Caline Lopes da Silva	04429876339	1970-01-01 00:00:35.989	86998083684	maviacaline_@hotmail.com	Rua das Palmeiras, 2296. Colorado 	\N	Elenilton de Morais Alves 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.707	2024-12-20 20:29:16.852	CONFIRMED
cm4cvtyqn007eo70fol7zvccn	Mizael Alves de Oliveira 	66038316353	1970-01-01 00:00:26.846	86988548801	mizaelalvesdeoliveira73@gmail.com	Rua Carlos Eugênio porto 	64046650	Claudenicer Maria de Sousa 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.711	2024-12-20 20:29:18.511	CONFIRMED
cm4cvtyqx007ko70fq44jfhe7	Nadia Caroline Lopes da Silva Braga	02810623317	1970-01-01 00:00:32.935	86995899113	nadiakarolinebraga@gmail.com	Quadra 6, casa 4, Residencial Frei Damião, Gurupi	64090155	Lucidio Braga da Cruz	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.721	2024-12-20 20:29:23.062	CONFIRMED
cm4cvtyr0007mo70f9nq67efx	Naiguel Lopes Borges	04288992346	1970-01-01 00:00:33.515	86 999442917	leugian@hotmail.com	Rua Noe Fortes, 400	64073046	Helaine Cristina Ribeiro Nascimento Borges	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.724	2024-12-20 20:29:24.959	CONFIRMED
cm4cvtyr3007oo70fo04ixxbd	Nairo Egídio Pereira Carvalho	05742879300	1970-01-01 00:00:34.343	86995108452	prih-macedo@hotmail.com	Rua 11 número 5135 Manoel evangelista 	64079112	Priscilla Macedo Noronha Carvalho	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.727	2024-12-20 20:29:27.575	CONFIRMED
cm4cvtyr9007so70fo0nd25km	Pablo Henrique Rocha Vieira	07485998358	1970-01-01 00:00:36.388	8999419-5340	pabllohenrique08@gmail.com	Rua Alameda dos Sabiás, 940	64093-040	Karen Larissa Rodrigues Braga	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.732	2024-12-20 20:29:33.141	CONFIRMED
cm4cvtyrd007uo70f8oxzjev6	Pamella Jainara Oliveira Lustosa 	02103455355	1970-01-01 00:00:35.165	86998497313	pamella_janaira@hotmail.com	Rua Belarmino Braga, 7752	64084023	Peniel Gomes Lustosa	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.736	2024-12-20 20:29:35.282	CONFIRMED
cm4cvtyrh007wo70frz9vevc0	Paulo Henrique da Cruz Viera	07123449347	1970-01-01 00:00:35.949	94991074008	paulo.h.noszoa@gmail.com	Avenida Expedito Ribeiro Gurupi	64090490	Francisca Aparecida Barroso da Silva	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.74	2024-12-20 20:29:37.212	CONFIRMED
cm4cvtyrk007yo70fplqapiv8	RAFAELA RODRIGUES DE PAULO	07260915374	1970-01-01 00:00:35.329	8699935-0452	raphaellamotta81@gmal.com	Rua Flor do tempo,8505	64088-680	Diego Gardean Paiva de Paulo	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.743	2024-12-20 20:29:39.329	CONFIRMED
cm4cvtyrn0080o70f8zrh9mp9	RAY LEVI ALVE DO NASCIMENTO	07255635326	1970-01-01 00:00:35.979	8699814-6623	raylevi03@outlook.com	Rua adão medeiros soares, 405	64080-105	Karine Oliveira da Silva	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.746	2024-12-20 20:29:41.018	CONFIRMED
cm4cvtyot0068o70fs84qdzo2	JOCASTRA LIMA PAZ	04849908373	1970-01-01 00:00:34.219	86998079576	Jocastralimapaz@hotmail.com	Av Professor Camilo filho , 5244	64093020	MICHAEL ANDERSON RODRIGUES SOARES	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.644	2024-12-20 20:28:22.473	CONFIRMED
cm4g6gsn300qqn10f6fqecxus	Vanessa Teixeira  Borges	66426197300	1979-12-04 00:00:00	86998210529	borgesvanessateixeira@gmail.com	Q 167 casa 16 Dirceu 2	64078046	Francisco Luís Bezerra Júnior 	f	cm4g6bh4n00qkn10fpcgql761	2024-12-08 22:30:59.583	2024-12-08 22:30:59.583	WAITING_LIST
cm4g6htwj00qrn10fec9mjmea	Paula Maysa de Sousa	06780925322	1996-04-19 00:00:00	86994037966	paulamaysa2014@gmail.con	Rua Antônio Gomes chaves 	64077808	Alberto costa do nascimento 	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:31:47.876	2024-12-08 22:31:47.876	WAITING_LIST
cm4g6kzmw00qsn10frq3fpajq	Francisca Érica Lucas Rodrigues 	04293896392	1990-10-17 00:00:00	86988863603	ferodrigues1790@gmail.com	Q. 165, 7 Dirceu 2	64078042	Sérgio Michel	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:34:15.272	2024-12-08 22:34:15.272	WAITING_LIST
cm4g6zicw00qtn10fix2gibqi	Sheyton Daniel Alves de Araújo 	60037933337	1987-11-18 00:00:00	86999468882	sheytondaniel@gmail.com	Rua Yolanda Raulino 3259	64090270	Maricelia Medeiros Barbosa de Araújo	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:45:32.72	2024-12-08 22:45:32.72	WAITING_LIST
cm4g72ahf00qun10f910wrrf1	MARIA FRANCISCA VIERA LIMA	83657614320	1971-05-30 00:00:00	86988933986	FRANCISCAMARIA57951@GMAIL.COM	QD 02 CS 02 CONJ PEDRA MOLE	64066000	PEDRO ALMEIDA DA SILVA	f	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:47:42.483	2024-12-08 22:47:42.483	WAITING_LIST
cm4g74zz100qwn10fn4lpjyl7	JONATAS BRAZ DA COSTA	02699870374	1988-01-17 00:00:00	86981461331	JONATASBRAZ@YAHOO.COM	RUA 11 CASA 2 PLANALTO BOA ESPERANÇA	65636822	VANUSA DA CONCEIÇÃO SILVA	f	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:49:48.829	2024-12-08 22:49:48.829	WAITING_LIST
cm4g7d54s00r0n10f471ykwsy	Laricia Kelly de oliveira Sousa 	06106057397	1998-07-17 00:00:00	86994956661	lalawk55@gmail.com	Rua seis 3323 samapi	64000000	Cristian Gabriel Nascimento de Matos	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:56:08.765	2024-12-08 22:56:08.765	WAITING_LIST
cm4g7i2xa00r2n10fvppm2hwi	FELICIO DE SOUSA SILVA	61141967324	1993-12-10 00:00:00	86988839192	COSTASUSANA42@GMAIL.COM	QD 45 CS 16 DIRCEU 1	64077124	SUSANA RODRIGUES DA COSTA SOUSA	f	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:59:59.182	2024-12-08 22:59:59.182	WAITING_LIST
cm4g6czzr00qpn10f53tu59td	Queren Silva Bezerra	07637320367	2003-12-05 00:00:00	86999588256	querensilvab@gmail.com	Rua Adão Medeiros Soares 475 Novo Horizonte	64080105	Victor Alencar do Nascimento 	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:28:02.488	2024-12-08 22:28:02.488	WAITING_LIST
cm4cvtysj008ko70fbdzenihw	Eldenice Sampaio de Sousa 	06026432361	1970-01-01 00:00:35.138	86998074450	eldenicessampaio@gmail.com	Rua Juiz Joaquim Lopes 	64057-670	Cássio Silvestre de Sousa Lima 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.778	2024-12-20 20:27:30.753	CONFIRMED
cm4cvtyo9005wo70fwo05eg27	Hilton Carlos Costa Sampaio	04872313330	1970-01-01 00:00:32.414	86994636037	hiltonsampaioweb@gmail.com	Alameda dos Sabiás, 940, Condomínio Reserva dos Sabiás 2, casa 30	64093040	Marta Rodrigues de Sousa Sampaio	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.625	2024-12-20 20:28:12.492	CONFIRMED
cm4g78l3c00qxn10f6xlinrca	DHIOSAFA KELSSIMO DA SLVA NASCIMENTO	01997474310	1988-02-12 00:00:00	86988109300	DHIOSAFANASCIMENTONASCIMENTO@GMAIL.COM	RUA NOVA ZELANDIA 4528 NOVO HORIZONTE	64079113	LEILIANE CARDOSO PIEROTE 	f	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:52:36.169	2024-12-20 20:26:16	WAITING_LIST
cm4cvtysg008io70f5unnqned	Josadeck Gomes Soares	04490830394	1970-01-01 00:00:32.634	86999584111	josadecksoares@gmail.com	Rua Anselmo Peretti	64078680	Ially Horrana Gomes Soares Lopes	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.775	2024-12-20 20:28:30.7	CONFIRMED
cm4cvtyoq0066o70f2vc0705d	Jhonildo de Sousa Rocha Monteiro	04200070324	1970-01-01 00:00:32.54	86994858540	jhonildorocha@gmail.com	Alameda dos Sabiás, 940, Condomínio Reserva dos Sabiás 2, casa 33	64093040	Elisane Monteiro Rocha	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.641	2024-12-20 20:28:24.391	CONFIRMED
cm4cvtyq80074o70fzu6weqmf	MARIA CAROLINA VIEIRA LIMA	07334564308	1970-01-01 00:00:35.613	86994282627	CAROLINAVIEIRAMARIA@GMAIL.COM	COND LENITA FERREIRA BL A APT 201	64093020	CARLOS HENRIQUE DA SILVA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.695	2024-12-20 20:28:59.267	CONFIRMED
cm4g7dun300r1n10f5x1qngxx	MARIA JAQUELINE CARDOSO DA SILVA TORRES	03869413352	1990-03-12 00:00:00	86995386904	JAQUECARDOSO120390@GMAIL.COM	QD 26 CASA26 RESID FREI DAMIÃO GURUPI	64090040	HELTON CLAUDIO TORRES AUGUSTO	t	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:56:41.823	2024-12-20 20:29:09.493	CONFIRMED
cm4cvtyrr0082o70f7akivflf	Ricardo Henrique Silva Cavalcante	03668672377	1970-01-01 00:00:32.61	8698899-0078	rhsc89@gmail.com	RESIDENCIAL COLORADO - Cond. Colorado.	64078-290	Yasmin Gomes da Silva Cavalcante	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.75	2024-12-20 20:29:44.882	CONFIRMED
cm4cvtyru0084o70fcvdp44xk	Sara Beatriz Saraiva Albuquerque 	06156115323	1970-01-01 00:00:35.339	86988197381	sabia1921@gmail.com	Q 05 casa 24	64095010	Caio Murilo da Conceição Albuquerque 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.753	2024-12-20 20:29:46.37	CONFIRMED
cm4cvtyry0086o70fj0mqoafc	Thiago Marques de Araujo	05581500398	1970-01-01 00:00:33.37	86 994427786	nildesousasilva@gmail.com	Rua 13, N 759 Bairro Planalto Boa Esperança Timon MA	65636842	Nilcelia de Sousa Araujo	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.757	2024-12-20 20:29:51.095	CONFIRMED
cm4cvtys10088o70felznlz1c	Tiago Pereira de Sousa	06066030345	1970-01-01 00:00:34.802	99981406285	thiagouchiha66@gmail.com	Quadra E, casa 16, Residencial Firmino Filho	64081090	Bruna Maria de Sousa Saraiva	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.76	2024-12-20 20:29:52.368	CONFIRMED
cm4cvtys7008co70f9g7jifkm	VANDSON GONÇALVES DE JESUS	06021150350	1970-01-01 00:00:35.12	86995202496	VANDSON1885@GMAIL.COM	RESIDENCIAL MONSENHOR CHAVES, QD B CASA 12	64031293	FRANCISCA GILSA SILVA DA COSTA	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.766	2024-12-20 20:29:55.149	CONFIRMED
cm4cvtys4008ao70fye8s39m4	VALDEZIR OLIVEIRA SANTOS	65774205304	1969-12-31 21:00:21	86999666366	EDUARDOPPSANTOS@GMAIL.COM	BOVOADO BOLENA S/N	6400000	EDUARDO PEREIRA DOS SANTOS	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 12:09:59	2024-12-20 20:29:53.617	CONFIRMED
cm4cvtys9008eo70fuciq905u	Wanderson Rosa Santos 	05529142311	1970-01-01 00:00:33.33	86 99940-7899	bferreiraamaral37@gmail.com	Pedro Balsi	64089-060 	Bianca Ferreira Amaral 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.769	2024-12-20 20:29:57.671	CONFIRMED
cm4cvtysd008go70fd728f0o7	Wanderson vieira dos santos 	07185975328	1970-01-01 00:00:34.854	86 99549-5042	wandersonv832@gmail.com	Quadra V casa 06 conjunto frei Damião alto da ressurreição 	64090-490	Bianca Rodrigo da conceição de Sousa 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.772	2024-12-20 20:29:59.349	CONFIRMED
cm4cvtyr6007qo70fse61p3yb	Natalia da Silva Lima Chaves	07834611356	1970-01-01 00:00:36.192	86998614821	natalialimamodelista@gmail.com	Avenida Ferroviária 8400, B. Todos os Santos	64088530	Wanderson de Sousa Chaves	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.729	2024-12-20 20:30:46.723	CONFIRMED
cm4g73k0400qvn10flkjg3jm8	Sara Emanuelle Soares do lago 	05477721308	2004-11-19 00:00:00	86988155140	saraemanuelle19@icloud.com	Rua estrela do norte,1642-Renascença	64082440	Jackson Vinícius Campos da Silva Araujo	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:48:41.476	2024-12-21 14:46:36.882	CONFIRMED
cm4cvtymn004yo70f0wpin22t	BRENO DE ARAUJO SILVA	06536064356	1970-01-01 00:00:35.708	86994351521	adm.breno2020@gmail.com	Rua josé evangelista de sousa, 5138 . Cond. Terrazo Horizonte Bloco 05 Ap 104	64079-063	Gessyca Fernandes de Sousa	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.566	2024-12-20 20:26:01.99	CONFIRMED
cm4g78zjo00qyn10fsbgdtee0	Nayra Anne Matos de Oliveira Moraes Paiva	03461951366	1990-02-01 00:00:00	8694004996	paivalelinho@hotmail.com	Rua São José 6956 - Alto da Ressurreicao	64090140	Laércio Fernando Lima de Paiva	f	cm4g69wr000qfn10fx31pc2in	2024-12-08 22:52:54.901	2024-12-21 14:42:15.196	CONFIRMED
cm4cvtymq0050o70fbnasda62	Claudenice Maria de Sousa	23981822315	1969-12-31 21:00:24	86 98892 3708	nicesousaoliveira195@gmail.com	Rua Carlos Eugênio Porto  771 São João Miz	64046650	Mizael Alves de Oliveira 	f	cm4c0pjb70000r10f75nd7pcf	2024-12-06 12:09:59	2024-12-06 12:09:59	WAITING_LIST
cm4g7b5eo00qzn10f5dyjcd2g	ANA CLAUDIA MACEDO DE OLIVEIRA CHAVES	00461974355	1981-05-14 00:00:00	86994985181	ANACLAUDIAMACEDO81@GMAIL.COM	QD H CASA 13 RESID PADRE PEDRO BALZI TODOS OS SANTOS	64089060	FRANCIALDO CHAVES ARAUJO	f	cm4fzg0al007cn10fpyjxb6xn	2024-12-08 22:54:35.808	2024-12-20 20:18:11.842	WAITING_LIST
cm4cvtykl004eo70fymza352v	Abimael de Sousa Rodrigues	05647816304	1970-01-01 00:00:33.885	86 994193455	ab100d@hotmail.com	Rua Alameda do Sabia, 940 C196 Verdecap	64043090	Leticia Crisitina Lima Paulino Rodrigues	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.492	2024-12-20 20:17:46.026	CONFIRMED
cm4cvtyo2005so70fwgippmvn	Gleyka Juliete de Oliveira Martins	06543046376	1970-01-01 00:00:35.556	86981255801	juliete.gleyka@gmail.com	Alameda dos Sabiás, 940, Condomínio Reserva dos Sabiás 2, casa 212	64093040	João Igor Costa do Nascimento 	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.618	2024-12-20 20:28:09.521	CONFIRMED
cm4cvtyon0064o70fb763omb9	JAMES CARLOS DOS SANTOS LIMA	05313064371	1970-01-01 00:00:34.133	86988964718	FDSOARES15@GMAIL.COM	RUA C QD F BAIRRO JOIA TIMON MA 	\N	FRANCILEIA DEBORA DOS SANTOS SOARES	t	cm4c0pjb70000r10f75nd7pcf	2024-12-06 15:09:59.638	2024-12-20 20:28:17.619	CONFIRMED
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Session" (id, "sessionToken", "userId", expires, "createdAt", "updatedAt") FROM stdin;
cm4fzg0au007gn10fp8pj4yr1	87f96ea3-f30d-4968-a443-d5e67aa163d6	cm4fzg0al007cn10fpyjxb6xn	2025-01-07 19:14:25.542	2024-12-08 19:14:25.543	2024-12-08 19:14:25.543
cm4g69wrl00qjn10fmg2ukmbl	1024a817-6a13-4098-8659-f9ee8c3d3a28	cm4g69wr000qfn10fx31pc2in	2025-01-07 22:25:38.336	2024-12-08 22:25:38.337	2024-12-08 22:25:38.337
cm4g6bh6h00qon10fee94y9dh	a23e8f5e-43b3-4f6f-8d98-3dd1f0b7a342	cm4g6bh4n00qkn10fpcgql761	2025-01-07 22:26:51.448	2024-12-08 22:26:51.449	2024-12-08 22:26:51.449
cm4c0pjej0004r10fg6vwtn4b	a78c7bae-fee0-4353-84b0-524759b6eb1d	cm4c0pjb70000r10f75nd7pcf	2025-01-09 16:57:52.521	2024-12-06 00:38:45.116	2024-12-10 16:57:52.769
cm4cvtuzq004co70fcvl693n3	064085f3-ba3f-4f5b-ac49-28b761b2a05a	cm4c0pjb70000r10f75nd7pcf	2025-01-09 17:19:53.585	2024-12-06 15:09:54.854	2024-12-10 17:19:53.586
cm4c28jt00004o70fl9i6vm0z	e03a3500-002e-43ad-80b0-5adf47da34a1	cm4c28jsn0000o70flh28vukl	2025-01-09 23:33:57.298	2024-12-06 01:21:31.717	2024-12-10 23:33:57.321
cm4k79edt000nmy0fw7jw4w0k	65527ca7-c624-4ccf-aa40-a244ada2bb28	cm4fzg0al007cn10fpyjxb6xn	2025-01-10 18:04:18.832	2024-12-11 18:04:18.834	2024-12-11 18:04:18.834
cm4vyjilt000xmy0flybvso2f	76f0a32f-26cf-4639-9593-4d8dc613c425	cm4vyjikf000tmy0fryvwvrn2	2025-01-18 23:33:28.431	2024-12-19 23:33:28.433	2024-12-19 23:33:28.433
cm4wz8xp20001o50fy3xxrn6p	9b34047d-3602-4ccc-9b7a-b0d02f4421d1	cm4vyjikf000tmy0fryvwvrn2	2025-01-19 16:41:00.565	2024-12-20 16:41:00.566	2024-12-20 16:41:00.566
cm4x6ncsk0001nz0fkklh44qb	85213769-e8bc-4d64-9d58-e0c632c2ee51	cm4c28jsn0000o70flh28vukl	2025-01-19 20:08:10.626	2024-12-20 20:08:10.629	2024-12-20 20:08:10.629
cm4o93tlg000smy0fdd5p3cux	688ac0c0-9d94-4e96-bd71-4c2607359b95	cm4o93tik000omy0f0phergx0	2025-01-21 12:59:32.917	2024-12-14 14:07:02.549	2024-12-22 12:59:32.919
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, email, "emailVerified", image, "isActive", "createdAt", "updatedAt") FROM stdin;
cm4c0pjb70000r10f75nd7pcf	Josadeck Soares	josadecksoares@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocKtYXN3E5wi-QCrpFmoxQkU9OTA1yrcDyy3lPMPYFUky33epBbG5g=s96-c	f	2024-12-06 00:38:44.996	2024-12-06 00:38:44.996
cm4c28jsn0000o70flh28vukl	Wanderson Chaves	wandersonchavesbr14@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocKLmh9zy6yetJlk0sONI0lSUJX2T8iR3wpyF9icv-svaXwebQ=s96-c	f	2024-12-06 01:21:31.704	2024-12-06 01:21:31.704
cm4fzg0al007cn10fpyjxb6xn	Gessyca Fernandes	gessyca.fernandes89@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocLmKV6ZFY6_h1FZI1s91a7r6nwbVLJHHgcJalxoMm0XsLaVt8CEdg=s96-c	f	2024-12-08 19:14:25.534	2024-12-08 19:14:25.534
cm4g69wr000qfn10fx31pc2in	Anderson Soares	andersonsoaresdev@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocKVNQpBIWKv0X7Cz6c0UmT0vx040B4nhSuRrRZTPEGgbDLkr0TK=s96-c	f	2024-12-08 22:25:38.317	2024-12-08 22:25:38.317
cm4g6bh4n00qkn10fpcgql761	Jocastra Lima Paz	jocastralimapaz@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocIW7BBIU_VcbO6CGvQFEgDso56KXtJuMNxktuabow3TGVkZq1X-=s96-c	f	2024-12-08 22:26:51.384	2024-12-08 22:26:51.384
cm4o93tik000omy0f0phergx0	Wanderson Chaves	wandersonscpibr@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocJUTqHEczMZg0D-S6maufZECzn8GeDDHxgVuzQAmdoUPj820XAnzQ=s96-c	f	2024-12-14 14:07:02.435	2024-12-14 14:07:02.435
cm4vyjikf000tmy0fryvwvrn2	Ially Soares	iallygsoares@gmail.com	\N	https://lh3.googleusercontent.com/a/ACg8ocIa-U399z9OFoF6j1EaydmoeflEGuBN1hst1t7795-X3i8E6Q4=s96-c	f	2024-12-19 23:33:28.335	2024-12-19 23:33:28.335
\.


--
-- Data for Name: VerificationToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."VerificationToken" (identifier, token, expires) FROM stdin;
\.


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- Name: Carnet Carnet_carnetId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carnet"
    ADD CONSTRAINT "Carnet_carnetId_key" UNIQUE ("carnetId");


--
-- Name: Carnet Carnet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carnet"
    ADD CONSTRAINT "Carnet_pkey" PRIMARY KEY (id);


--
-- Name: Charge Charge_chargeId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Charge"
    ADD CONSTRAINT "Charge_chargeId_key" UNIQUE ("chargeId");


--
-- Name: Charge Charge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Charge"
    ADD CONSTRAINT "Charge_pkey" PRIMARY KEY (id);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON public."Account" USING btree (provider, "providerAccountId");


--
-- Name: Account_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Account_userId_idx" ON public."Account" USING btree ("userId");


--
-- Name: Customer_cpf_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Customer_cpf_key" ON public."Customer" USING btree (cpf);


--
-- Name: Session_sessionToken_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Session_sessionToken_key" ON public."Session" USING btree ("sessionToken");


--
-- Name: Session_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Session_userId_idx" ON public."Session" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: VerificationToken_identifier_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON public."VerificationToken" USING btree (identifier, token);


--
-- Name: VerificationToken_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "VerificationToken_token_key" ON public."VerificationToken" USING btree (token);


--
-- Name: Account Account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Carnet Carnet_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carnet"
    ADD CONSTRAINT "Carnet_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Charge Charge_carnetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Charge"
    ADD CONSTRAINT "Charge_carnetId_fkey" FOREIGN KEY ("carnetId") REFERENCES public."Carnet"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Customer Customer_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Session Session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

