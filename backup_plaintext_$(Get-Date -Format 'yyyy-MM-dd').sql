--
-- PostgreSQL database dump
--

\restrict UDNCnKqlxUfJarcaeQEkk1ej1cJgTmAqBOXpNYdK2qb8wvi6w3kSI7p3HoghdHU

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.1

-- Started on 2026-04-26 22:42:46

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
-- TOC entry 25 (class 2615 OID 16494)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 20 (class 2615 OID 16388)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 24 (class 2615 OID 16624)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 23 (class 2615 OID 16613)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 9 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 10 (class 2615 OID 16605)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 26 (class 2615 OID 16542)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 22 (class 2615 OID 16653)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 4 (class 3079 OID 16389)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 2 (class 3079 OID 16443)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16654)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 3 (class 3079 OID 16432)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1176 (class 1247 OID 16784)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1200 (class 1247 OID 16925)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1173 (class 1247 OID 16778)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1170 (class 1247 OID 16773)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1218 (class 1247 OID 17028)
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1230 (class 1247 OID 17101)
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1212 (class 1247 OID 17006)
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1221 (class 1247 OID 17038)
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1206 (class 1247 OID 16967)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1257 (class 1247 OID 17316)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1248 (class 1247 OID 17277)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1251 (class 1247 OID 17291)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1263 (class 1247 OID 17358)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1260 (class 1247 OID 17329)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 1239 (class 1247 OID 17236)
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- TOC entry 434 (class 1255 OID 16540)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 444 (class 1255 OID 16755)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 398 (class 1255 OID 16539)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 410 (class 1255 OID 16538)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 464 (class 1255 OID 16597)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 450 (class 1255 OID 16618)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 425 (class 1255 OID 16599)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 395 (class 1255 OID 16609)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 481 (class 1255 OID 16610)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 403 (class 1255 OID 16620)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 510 (class 1255 OID 134084)
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- TOC entry 438 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 431 (class 1255 OID 86653)
-- Name: get_all_users_with_roles(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_users_with_roles() RETURNS TABLE(id uuid, user_id uuid, email text, role text, created_at timestamp with time zone, updated_at timestamp with time zone, updated_by uuid)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    -- Verificar que quien ejecuta sea super_admin
    IF NOT EXISTS (
        SELECT 1 FROM public.user_roles ur_check
        WHERE ur_check.user_id = auth.uid() AND ur_check.role = 'super_admin'
    ) THEN
        RAISE EXCEPTION 'No tienes permisos para ver usuarios';
    END IF;

    -- Retornar todos los usuarios de auth.users con su rol correspondiente
    RETURN QUERY
    SELECT 
        COALESCE(ur.id, gen_random_uuid()) as id,
        u.id as user_id,
        u.email::TEXT as email,
        COALESCE(ur.role, 'invitado') as role,
        COALESCE(ur.created_at, u.created_at) as created_at,
        ur.updated_at,
        ur.updated_by
    FROM auth.users u
    LEFT JOIN public.user_roles ur ON ur.user_id = u.id
    ORDER BY COALESCE(ur.created_at, u.created_at) DESC;
END;
$$;


ALTER FUNCTION public.get_all_users_with_roles() OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 86595)
-- Name: get_user_role(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_role(user_id_param uuid) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
    user_role TEXT;
BEGIN
    SELECT role INTO user_role
    FROM public.user_roles
    WHERE user_id = user_id_param;
    
    RETURN COALESCE(user_role, 'invitado');
END;
$$;


ALTER FUNCTION public.get_user_role(user_id_param uuid) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 86578)
-- Name: handle_new_user_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user_role() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    INSERT INTO public.user_roles (user_id, email, role)
    VALUES (NEW.id, NEW.email, 'invitado');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user_role() OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 134058)
-- Name: reacciones_conteo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reacciones_conteo() RETURNS TABLE(emoji text, total bigint)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
    SELECT emoji, COUNT(*) as total
    FROM public.reacciones
    GROUP BY emoji
    ORDER BY total DESC;
$$;


ALTER FUNCTION public.reacciones_conteo() OWNER TO postgres;

--
-- TOC entry 419 (class 1255 OID 47764)
-- Name: reacciones_conteo(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reacciones_conteo(mensaje uuid) RETURNS TABLE(emoji text, total bigint)
    LANGUAGE sql STABLE
    AS $$
  SELECT emoji, COUNT(DISTINCT session_id)::bigint AS total
  FROM reacciones
  WHERE mensaje_id = mensaje
  GROUP BY emoji;
$$;


ALTER FUNCTION public.reacciones_conteo(mensaje uuid) OWNER TO postgres;

--
-- TOC entry 407 (class 1255 OID 86596)
-- Name: user_has_role(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_has_role(required_role text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
    current_role TEXT;
BEGIN
    SELECT role INTO current_role
    FROM public.user_roles
    WHERE user_id = auth.uid();
    
    IF current_role = 'super_admin' THEN
        RETURN TRUE;
    END IF;
    
    IF current_role = 'admin' AND required_role IN ('admin', 'invitado') THEN
        RETURN TRUE;
    END IF;
    
    IF current_role = 'invitado' AND required_role = 'invitado' THEN
        RETURN TRUE;
    END IF;
    
    RETURN FALSE;
END;
$$;


ALTER FUNCTION public.user_has_role(required_role text) OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 17351)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 502 (class 1255 OID 17432)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 414 (class 1255 OID 17364)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 467 (class 1255 OID 17313)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 437 (class 1255 OID 17308)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 479 (class 1255 OID 17359)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 421 (class 1255 OID 129419)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 420 (class 1255 OID 17307)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 506 (class 1255 OID 17431)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 497 (class 1255 OID 17305)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 454 (class 1255 OID 17340)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 477 (class 1255 OID 17425)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 462 (class 1255 OID 128261)
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 436 (class 1255 OID 128260)
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- TOC entry 468 (class 1255 OID 17140)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 440 (class 1255 OID 17255)
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 426 (class 1255 OID 17233)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 485 (class 1255 OID 17114)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 445 (class 1255 OID 17113)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 413 (class 1255 OID 17112)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 472 (class 1255 OID 86641)
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- TOC entry 447 (class 1255 OID 17196)
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 465 (class 1255 OID 17212)
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 474 (class 1255 OID 17213)
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 442 (class 1255 OID 17231)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 486 (class 1255 OID 17179)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 448 (class 1255 OID 86642)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- TOC entry 458 (class 1255 OID 17195)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 505 (class 1255 OID 86647)
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- TOC entry 457 (class 1255 OID 17129)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 422 (class 1255 OID 86645)
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 469 (class 1255 OID 17229)
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 433 (class 1255 OID 17253)
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 463 (class 1255 OID 17130)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 339 (class 1259 OID 16525)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 385 (class 1259 OID 100101)
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 355 (class 1259 OID 16929)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4613 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- TOC entry 346 (class 1259 OID 16727)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4615 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 338 (class 1259 OID 16518)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 350 (class 1259 OID 16816)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 349 (class 1259 OID 16804)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 348 (class 1259 OID 16791)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 348
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- TOC entry 358 (class 1259 OID 17041)
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- TOC entry 375 (class 1259 OID 40872)
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 375
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- TOC entry 357 (class 1259 OID 17011)
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- TOC entry 359 (class 1259 OID 17074)
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- TOC entry 356 (class 1259 OID 16979)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 337 (class 1259 OID 16507)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 336 (class 1259 OID 16506)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 336
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 353 (class 1259 OID 16858)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 354 (class 1259 OID 16876)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 340 (class 1259 OID 16533)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 347 (class 1259 OID 16757)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- TOC entry 352 (class 1259 OID 16843)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 351 (class 1259 OID 16834)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 335 (class 1259 OID 16495)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 387 (class 1259 OID 118109)
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 386 (class 1259 OID 118086)
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- TOC entry 370 (class 1259 OID 17452)
-- Name: canciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.canciones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    titulo text,
    artista text,
    url text,
    path text,
    tipo text,
    creado_en timestamp with time zone DEFAULT now(),
    owner uuid,
    publico boolean DEFAULT true
);


ALTER TABLE public.canciones OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 88895)
-- Name: card_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.card_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender text NOT NULL,
    receiver text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.card_logs OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 88884)
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender text NOT NULL,
    receiver text NOT NULL,
    drawing jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 17517)
-- Name: fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fotos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    titulo text,
    descripcion text,
    url text NOT NULL,
    path text NOT NULL,
    tipo text DEFAULT 'foto'::text,
    owner uuid,
    publico boolean DEFAULT true,
    creado_en timestamp with time zone DEFAULT now()
);


ALTER TABLE public.fotos OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 17532)
-- Name: mensajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    autor text,
    texto text NOT NULL,
    privado boolean DEFAULT false,
    referencia_tipo text,
    referencia_id uuid,
    creado_en timestamp with time zone DEFAULT now(),
    categoria text,
    emoji text DEFAULT '💕'::text,
    nota text,
    user_id uuid
);


ALTER TABLE public.mensajes OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 47508)
-- Name: reacciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reacciones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mensaje_id uuid,
    emoji text NOT NULL,
    creado_en timestamp with time zone DEFAULT now(),
    session_id text NOT NULL,
    user_id uuid
);


ALTER TABLE public.reacciones OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 88905)
-- Name: shared_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_cards (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender text NOT NULL,
    receiver text NOT NULL,
    drawing jsonb NOT NULL,
    quote_index integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.shared_cards OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 72907)
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profiles (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 72906)
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_profiles_id_seq OWNER TO postgres;

--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 377
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- TOC entry 381 (class 1259 OID 86549)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    email text NOT NULL,
    role text DEFAULT 'invitado'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    updated_by uuid,
    CONSTRAINT valid_role CHECK ((role = ANY (ARRAY['super_admin'::text, 'admin'::text, 'invitado'::text])))
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 76374)
-- Name: visitor_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitor_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    visitor_id text NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now(),
    ip_publica text,
    ip_local text,
    isp text,
    asn text,
    pais text,
    codigo_pais text,
    region text,
    ciudad text,
    codigo_postal text,
    latitud numeric,
    longitud numeric,
    zona_horaria text,
    navegador text,
    sistema_operativo text,
    plataforma text,
    tipo_dispositivo text,
    es_movil boolean DEFAULT false,
    user_agent text,
    resolucion_pantalla text,
    profundidad_color integer,
    nucleos_cpu integer,
    memoria text,
    idioma text,
    idiomas text[],
    cookies_habilitadas boolean,
    dnt text,
    canvas_fp text,
    webgl_vendor text,
    webgl_renderer text,
    fingerprint_unico text,
    url_actual text,
    url_referrer text,
    datos_completos jsonb,
    created_at timestamp with time zone DEFAULT now(),
    distrito character varying(255),
    conexion_tipo character varying(50),
    organizacion character varying(255),
    gps_latitud numeric(10,7),
    gps_longitud numeric(10,7),
    gps_precision integer,
    gps_altitud numeric(10,2),
    gps_velocidad numeric(8,2),
    gps_estado character varying(50)
);


ALTER TABLE public.visitor_logs OWNER TO postgres;

--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE visitor_logs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.visitor_logs IS 'Registro de visitantes con información detallada del dispositivo y ubicación';


--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.distrito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.distrito IS 'Distrito o barrio (solo disponible con IPGeolocation.io)';


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.conexion_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.conexion_tipo IS 'Tipo de conexión: dialup, cable, cellular, etc.';


--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.organizacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.organizacion IS 'Organización propietaria del rango IP';


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_latitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_latitud IS 'Latitud GPS real del dispositivo (más precisa que IP)';


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_longitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_longitud IS 'Longitud GPS real del dispositivo';


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_precision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_precision IS 'Precisión del GPS en metros';


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_altitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_altitud IS 'Altitud en metros sobre nivel del mar';


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_velocidad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_velocidad IS 'Velocidad del dispositivo en m/s';


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 379
-- Name: COLUMN visitor_logs.gps_estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor_logs.gps_estado IS 'Estado de la captura GPS: Obtenido, Permiso denegado, No soportado, etc.';


--
-- TOC entry 380 (class 1259 OID 77528)
-- Name: visitor_stats; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.visitor_stats WITH (security_invoker='true') AS
 SELECT count(*) AS total_visitas,
    count(DISTINCT ip_publica) AS ips_unicas,
    count(DISTINCT pais) AS paises_unicos,
    count(
        CASE
            WHEN (date("timestamp") = CURRENT_DATE) THEN 1
            ELSE NULL::integer
        END) AS visitas_hoy,
    count(
        CASE
            WHEN (es_movil = true) THEN 1
            ELSE NULL::integer
        END) AS visitas_moviles,
    count(
        CASE
            WHEN (tipo_dispositivo = 'Desktop'::text) THEN 1
            ELSE NULL::integer
        END) AS visitas_desktop
   FROM public.visitor_logs;


ALTER VIEW public.visitor_stats OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 17435)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 388 (class 1259 OID 133921)
-- Name: messages_2026_04_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_24 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_24 OWNER TO supabase_admin;

--
-- TOC entry 389 (class 1259 OID 133933)
-- Name: messages_2026_04_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_25 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_25 OWNER TO supabase_admin;

--
-- TOC entry 390 (class 1259 OID 133945)
-- Name: messages_2026_04_26; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_26 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_26 OWNER TO supabase_admin;

--
-- TOC entry 391 (class 1259 OID 133957)
-- Name: messages_2026_04_27; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_27 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 392 (class 1259 OID 133969)
-- Name: messages_2026_04_28; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_28 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_28 OWNER TO supabase_admin;

--
-- TOC entry 393 (class 1259 OID 134067)
-- Name: messages_2026_04_29; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_29 OWNER TO supabase_admin;

--
-- TOC entry 394 (class 1259 OID 134085)
-- Name: messages_2026_04_30; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_30 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_30 OWNER TO supabase_admin;

--
-- TOC entry 363 (class 1259 OID 17271)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 366 (class 1259 OID 17293)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 365 (class 1259 OID 17292)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 341 (class 1259 OID 16546)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 341
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 362 (class 1259 OID 17242)
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- TOC entry 373 (class 1259 OID 23159)
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- TOC entry 343 (class 1259 OID 16588)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 342 (class 1259 OID 16561)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 360 (class 1259 OID 17144)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 361 (class 1259 OID 17158)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 374 (class 1259 OID 23169)
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- TOC entry 3729 (class 0 OID 0)
-- Name: messages_2026_04_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_24 FOR VALUES FROM ('2026-04-24 00:00:00') TO ('2026-04-25 00:00:00');


--
-- TOC entry 3730 (class 0 OID 0)
-- Name: messages_2026_04_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_25 FOR VALUES FROM ('2026-04-25 00:00:00') TO ('2026-04-26 00:00:00');


--
-- TOC entry 3731 (class 0 OID 0)
-- Name: messages_2026_04_26; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_26 FOR VALUES FROM ('2026-04-26 00:00:00') TO ('2026-04-27 00:00:00');


--
-- TOC entry 3732 (class 0 OID 0)
-- Name: messages_2026_04_27; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00') TO ('2026-04-28 00:00:00');


--
-- TOC entry 3733 (class 0 OID 0)
-- Name: messages_2026_04_28; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_28 FOR VALUES FROM ('2026-04-28 00:00:00') TO ('2026-04-29 00:00:00');


--
-- TOC entry 3734 (class 0 OID 0)
-- Name: messages_2026_04_29; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_29 FOR VALUES FROM ('2026-04-29 00:00:00') TO ('2026-04-30 00:00:00');


--
-- TOC entry 3735 (class 0 OID 0)
-- Name: messages_2026_04_30; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_30 FOR VALUES FROM ('2026-04-30 00:00:00') TO ('2026-05-01 00:00:00');


--
-- TOC entry 3745 (class 2604 OID 16510)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3813 (class 2604 OID 72910)
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- TOC entry 4457 (class 0 OID 16525)
-- Dependencies: 339
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- TOC entry 4496 (class 0 OID 100101)
-- Dependencies: 385
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4471 (class 0 OID 16929)
-- Dependencies: 355
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- TOC entry 4462 (class 0 OID 16727)
-- Dependencies: 346
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	{"sub": "71ca4c2d-1c75-4b9e-a854-fa996aa06f6f", "email": "leonardopenaanez@gmail.com", "username": "leonardo", "created_at": "2026-02-08T03:37:44.904Z", "display_name": "leonardo", "email_verified": true, "phone_verified": false}	email	2026-02-08 03:37:36.592044+00	2026-02-08 03:37:36.592097+00	2026-02-08 03:37:36.592097+00	b123e684-163d-4053-a9a0-266aa76c1999
0a4d4080-3cc7-46c0-833b-cc2179b9896c	0a4d4080-3cc7-46c0-833b-cc2179b9896c	{"sub": "0a4d4080-3cc7-46c0-833b-cc2179b9896c", "email": "rociomilagros268@gmail.com", "username": "rocio", "created_at": "2026-02-08T04:26:57.169Z", "display_name": "rocio", "email_verified": true, "phone_verified": false}	email	2026-02-08 04:26:58.182594+00	2026-02-08 04:26:58.182641+00	2026-02-08 04:26:58.182641+00	a3116891-2b28-4ce7-9d58-a3ed012bfc23
ad47de29-35ee-429a-b7aa-e1813cbf0b05	ad47de29-35ee-429a-b7aa-e1813cbf0b05	{"sub": "ad47de29-35ee-429a-b7aa-e1813cbf0b05", "email": "clientebot6001@gmail.com", "username": "cliente1", "created_at": "2026-02-09T00:13:00.668Z", "display_name": "cliente1", "email_verified": true, "phone_verified": false}	email	2026-02-09 00:13:01.603998+00	2026-02-09 00:13:01.604056+00	2026-02-09 00:13:01.604056+00	27141972-14d4-4e8f-89d1-a95c73f39ab3
c12277ce-d3cc-42cc-b148-86e27d5943eb	c12277ce-d3cc-42cc-b148-86e27d5943eb	{"sub": "c12277ce-d3cc-42cc-b148-86e27d5943eb", "email": "cliente2pruebaa@gmail.com", "username": "prueba2", "created_at": "2026-03-11T15:06:22.061Z", "display_name": "prueba2", "email_verified": true, "phone_verified": false}	email	2026-03-11 15:06:22.125933+00	2026-03-11 15:06:22.125984+00	2026-03-11 15:06:22.125984+00	a7fadbd8-6bee-4b97-88f0-9035f5b4300b
\.


--
-- TOC entry 4456 (class 0 OID 16518)
-- Dependencies: 338
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4466 (class 0 OID 16816)
-- Dependencies: 350
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
0eff4812-78cf-4fe4-95fe-a80bdc7db4d2	2026-04-02 18:48:57.872842+00	2026-04-02 18:48:57.872842+00	password	73728b4c-3a55-4d49-bff7-0b3eb051dd14
9fe520ea-5fc0-4990-963f-890239b9905e	2026-04-27 02:01:50.880787+00	2026-04-27 02:01:50.880787+00	password	48ca8626-1f3b-4209-a674-54d23d43903c
f9198273-428c-4123-af79-f2b2f642670c	2026-02-08 04:27:52.047209+00	2026-02-08 04:27:52.047209+00	otp	6bfc0276-dd5d-4aaf-99eb-72381149d9de
0ff10530-3893-42ee-ab65-b55dac2e89cd	2026-02-08 04:28:02.471284+00	2026-02-08 04:28:02.471284+00	password	110e23ca-e370-485f-ac7c-6d03861b2cb6
37cc77b2-90cb-410a-9c82-aeaf90eaa363	2026-03-11 15:11:18.318466+00	2026-03-11 15:11:18.318466+00	otp	e679fcbb-154c-4264-80c2-dbbb25b62c19
\.


--
-- TOC entry 4465 (class 0 OID 16804)
-- Dependencies: 349
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4464 (class 0 OID 16791)
-- Dependencies: 348
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- TOC entry 4474 (class 0 OID 17041)
-- Dependencies: 358
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- TOC entry 4487 (class 0 OID 40872)
-- Dependencies: 375
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- TOC entry 4473 (class 0 OID 17011)
-- Dependencies: 357
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- TOC entry 4475 (class 0 OID 17074)
-- Dependencies: 359
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- TOC entry 4472 (class 0 OID 16979)
-- Dependencies: 356
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4455 (class 0 OID 16507)
-- Dependencies: 337
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	110	7ub4p26puze5	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-30 05:50:13.28317+00	2026-03-30 14:46:31.767865+00	q52gx42mic74	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	30	x57ssmk7yvyw	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-08 22:03:04.309377+00	2026-02-12 00:54:20.760823+00	f7zb4rewpq6p	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	154	a4uwmaacpwez	0a4d4080-3cc7-46c0-833b-cc2179b9896c	f	2026-04-27 02:35:01.175129+00	2026-04-27 02:35:01.175129+00	mj4y75mrhpoy	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	49	73wu3nrsi772	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-12 00:54:20.790379+00	2026-02-12 03:28:22.156788+00	x57ssmk7yvyw	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	50	ynnhmvntxo6s	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-12 03:28:22.183336+00	2026-02-14 05:36:08.312451+00	73wu3nrsi772	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	111	lelfdbhzp24e	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-30 14:46:31.794775+00	2026-04-02 18:48:33.834824+00	7ub4p26puze5	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	53	eb7px7dmia6b	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-14 05:36:08.329481+00	2026-02-14 09:05:12.422704+00	ynnhmvntxo6s	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	115	o2vhlvd5kvhp	0a4d4080-3cc7-46c0-833b-cc2179b9896c	f	2026-04-02 18:48:33.85951+00	2026-04-02 18:48:33.85951+00	lelfdbhzp24e	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	54	aoggacr7c7ch	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-14 09:05:12.449196+00	2026-02-14 14:00:17.002276+00	eb7px7dmia6b	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	55	zhtcpaqrso43	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-14 14:00:17.032514+00	2026-02-14 15:01:55.238422+00	aoggacr7c7ch	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	56	jv5ikfpvq7ny	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-14 15:01:55.256278+00	2026-02-14 17:11:34.039868+00	zhtcpaqrso43	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	58	hkahhavot73p	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-14 17:11:34.068706+00	2026-02-15 04:32:06.980273+00	jv5ikfpvq7ny	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	116	oy4nstyaaopa	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-02 18:48:57.871503+00	2026-04-07 21:28:08.783198+00	\N	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	59	w3pceujvow4b	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-15 04:32:07.005385+00	2026-02-15 08:19:26.172021+00	hkahhavot73p	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	60	fdzztioyoxu2	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-15 08:19:26.194231+00	2026-02-16 06:52:46.782471+00	w3pceujvow4b	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	62	deya6ff4krbm	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-16 06:52:46.804404+00	2026-02-17 14:26:46.542534+00	fdzztioyoxu2	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	63	qnelb4x6qodk	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-17 14:26:46.572989+00	2026-02-19 03:14:02.969526+00	deya6ff4krbm	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	28	xppztzysowec	0a4d4080-3cc7-46c0-833b-cc2179b9896c	f	2026-02-08 04:27:52.043345+00	2026-02-08 04:27:52.043345+00	\N	f9198273-428c-4123-af79-f2b2f642670c
00000000-0000-0000-0000-000000000000	64	olxiquw4gvsf	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-19 03:14:02.999608+00	2026-02-20 05:29:06.718444+00	qnelb4x6qodk	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	29	f7zb4rewpq6p	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-08 04:28:02.470045+00	2026-02-08 22:03:04.286396+00	\N	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	66	zkiwvnpdxodw	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-20 05:29:06.743638+00	2026-02-22 02:24:09.809794+00	olxiquw4gvsf	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	68	wfb5bm6nr5gj	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-22 02:24:09.830745+00	2026-02-23 04:21:25.922831+00	zkiwvnpdxodw	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	69	zhk4zta3to72	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-23 04:21:25.95588+00	2026-02-26 21:05:34.44523+00	wfb5bm6nr5gj	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	75	dx2pud7hdgmo	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-02-26 21:05:34.46854+00	2026-03-01 16:39:50.39061+00	zhk4zta3to72	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	76	7vr2ijnukem7	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-01 16:39:50.413598+00	2026-03-03 21:10:06.886832+00	dx2pud7hdgmo	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	77	r2jpj6mk2pzc	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-03 21:10:06.918478+00	2026-03-04 10:28:59.701641+00	7vr2ijnukem7	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	78	dsga7jr4ji4t	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-04 10:28:59.724194+00	2026-03-07 19:15:18.87857+00	r2jpj6mk2pzc	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	80	fog65zszqcui	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-07 19:15:18.911199+00	2026-03-08 04:54:04.645833+00	dsga7jr4ji4t	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	90	nj32fbodoqhs	c12277ce-d3cc-42cc-b148-86e27d5943eb	f	2026-03-11 15:11:18.307947+00	2026-03-11 15:11:18.307947+00	\N	37cc77b2-90cb-410a-9c82-aeaf90eaa363
00000000-0000-0000-0000-000000000000	81	f6oksjkwnxbt	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-08 04:54:04.673173+00	2026-03-13 03:15:17.155343+00	fog65zszqcui	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	96	zexwkj6tmy6e	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-13 03:15:17.181031+00	2026-03-17 04:10:23.240962+00	f6oksjkwnxbt	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	103	7csymyelnxeo	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-17 04:10:23.249927+00	2026-03-21 04:12:54.157736+00	zexwkj6tmy6e	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	105	m3m2swh6tfb6	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-21 04:12:54.18827+00	2026-03-27 03:22:23.326686+00	7csymyelnxeo	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	107	ht5x4dslqkos	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-27 03:22:23.356096+00	2026-03-29 03:59:17.8753+00	m3m2swh6tfb6	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	109	q52gx42mic74	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-03-29 03:59:17.910044+00	2026-03-30 05:50:13.258921+00	ht5x4dslqkos	0ff10530-3893-42ee-ab65-b55dac2e89cd
00000000-0000-0000-0000-000000000000	153	p2l7u46fj3yh	c12277ce-d3cc-42cc-b148-86e27d5943eb	f	2026-04-27 02:01:50.871792+00	2026-04-27 02:01:50.871792+00	\N	9fe520ea-5fc0-4990-963f-890239b9905e
00000000-0000-0000-0000-000000000000	147	mj4y75mrhpoy	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-26 17:47:02.498161+00	2026-04-27 02:35:01.131182+00	clupwanurdv7	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	119	5hkw4wutm26a	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-07 21:28:08.812103+00	2026-04-08 05:01:00.721213+00	oy4nstyaaopa	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	121	365ji5hfave6	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-08 05:01:00.744392+00	2026-04-08 12:28:21.33969+00	5hkw4wutm26a	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	122	itcavdukppem	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-08 12:28:21.369412+00	2026-04-08 18:11:12.463981+00	365ji5hfave6	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	125	jhzvg5igv2hy	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-08 18:11:12.481565+00	2026-04-09 00:26:30.551978+00	itcavdukppem	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	126	yxgc6pqygbng	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-09 00:26:30.577564+00	2026-04-10 22:42:16.058919+00	jhzvg5igv2hy	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	128	vbkel3s5x72s	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-10 22:42:16.082187+00	2026-04-15 03:36:26.490888+00	yxgc6pqygbng	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	129	cv4c5ustwtxk	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-15 03:36:26.519678+00	2026-04-16 11:54:03.646231+00	vbkel3s5x72s	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	131	mrooldn2gdrj	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-16 11:54:03.678883+00	2026-04-19 20:40:42.145493+00	cv4c5ustwtxk	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	132	gi4drtoaobeh	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-19 20:40:42.173551+00	2026-04-20 02:55:44.989948+00	mrooldn2gdrj	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	133	3qtmmym6udey	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-20 02:55:45.010593+00	2026-04-23 18:41:20.456181+00	gi4drtoaobeh	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	134	oaxloa3fm33l	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-23 18:41:20.480995+00	2026-04-24 04:21:08.931947+00	3qtmmym6udey	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	135	bk3mvmdrnarq	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-24 04:21:08.958032+00	2026-04-24 15:05:11.166785+00	oaxloa3fm33l	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	136	4l4btermufdo	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-24 15:05:11.191992+00	2026-04-25 03:14:17.207698+00	bk3mvmdrnarq	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	138	nsdjdlllbblu	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-25 03:14:17.239099+00	2026-04-25 19:32:54.624276+00	4l4btermufdo	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	140	kzco6ydrup4f	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-25 19:32:54.648519+00	2026-04-26 03:57:14.160164+00	nsdjdlllbblu	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
00000000-0000-0000-0000-000000000000	146	clupwanurdv7	0a4d4080-3cc7-46c0-833b-cc2179b9896c	t	2026-04-26 03:57:14.1834+00	2026-04-26 17:47:02.471681+00	kzco6ydrup4f	0eff4812-78cf-4fe4-95fe-a80bdc7db4d2
\.


--
-- TOC entry 4469 (class 0 OID 16858)
-- Dependencies: 353
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4470 (class 0 OID 16876)
-- Dependencies: 354
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4458 (class 0 OID 16533)
-- Dependencies: 340
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- TOC entry 4463 (class 0 OID 16757)
-- Dependencies: 347
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
37cc77b2-90cb-410a-9c82-aeaf90eaa363	c12277ce-d3cc-42cc-b148-86e27d5943eb	2026-03-11 15:11:18.301071+00	2026-03-11 15:11:18.301071+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	189.28.75.192	\N	\N	\N	\N	\N
f9198273-428c-4123-af79-f2b2f642670c	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-02-08 04:27:52.034909+00	2026-02-08 04:27:52.034909+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	181.238.113.149	\N	\N	\N	\N	\N
0ff10530-3893-42ee-ab65-b55dac2e89cd	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-02-08 04:28:02.468183+00	2026-04-02 18:48:33.886445+00	\N	aal1	\N	2026-04-02 18:48:33.885713	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	186.157.76.126	\N	\N	\N	\N	\N
9fe520ea-5fc0-4990-963f-890239b9905e	c12277ce-d3cc-42cc-b148-86e27d5943eb	2026-04-27 02:01:50.859187+00	2026-04-27 02:01:50.859187+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	192.223.114.89	\N	\N	\N	\N	\N
0eff4812-78cf-4fe4-95fe-a80bdc7db4d2	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-04-02 18:48:57.861461+00	2026-04-27 02:35:01.203516+00	\N	aal1	\N	2026-04-27 02:35:01.203406	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	181.239.164.245	\N	\N	\N	\N	\N
\.


--
-- TOC entry 4468 (class 0 OID 16843)
-- Dependencies: 352
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4467 (class 0 OID 16834)
-- Dependencies: 351
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- TOC entry 4453 (class 0 OID 16495)
-- Dependencies: 335
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	0a4d4080-3cc7-46c0-833b-cc2179b9896c	authenticated	authenticated	rociomilagros268@gmail.com	$2a$10$YE.nyRBcA3CJeQ55wyTEHOM4DWjWNcPi/p5gN2d1vgFLQGGxr7o66	2026-02-08 04:27:52.02646+00	\N		2026-02-08 04:26:58.191874+00		\N			\N	2026-04-02 18:48:57.86137+00	{"provider": "email", "providers": ["email"]}	{"sub": "0a4d4080-3cc7-46c0-833b-cc2179b9896c", "email": "rociomilagros268@gmail.com", "username": "rocio", "created_at": "2026-02-08T04:26:57.169Z", "display_name": "rocio", "email_verified": true, "phone_verified": false}	\N	2026-02-08 04:26:58.154679+00	2026-04-27 02:35:01.193023+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ad47de29-35ee-429a-b7aa-e1813cbf0b05	authenticated	authenticated	clientebot6001@gmail.com	$2a$10$nJkRvEN2P8qRATBMFoYNO.gLsrVVqyshvr2YCRzH.Jirp/P8y3mdi	2026-02-09 00:13:30.131176+00	\N		2026-02-09 00:13:01.617075+00		\N			\N	2026-04-27 01:57:13.305863+00	{"provider": "email", "providers": ["email"]}	{"sub": "ad47de29-35ee-429a-b7aa-e1813cbf0b05", "email": "clientebot6001@gmail.com", "username": "cliente1", "created_at": "2026-02-09T00:13:00.668Z", "display_name": "cliente1", "email_verified": true, "phone_verified": false}	\N	2026-02-09 00:13:01.539216+00	2026-04-27 01:57:13.332411+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	authenticated	authenticated	leonardopenaanez@gmail.com	$2a$10$i4T0ZfMSOyTHejsY2Oly/.n6zjEVTkWxoV6w7bfY5E0u4KXw3gFti	2026-02-08 03:39:33.899394+00	\N		2026-02-08 03:37:36.602331+00		\N			\N	2026-04-27 01:58:36.593519+00	{"provider": "email", "providers": ["email"]}	{"sub": "71ca4c2d-1c75-4b9e-a854-fa996aa06f6f", "email": "leonardopenaanez@gmail.com", "username": "leonardo", "created_at": "2026-02-08T03:37:44.904Z", "display_name": "leonardo", "email_verified": true, "phone_verified": false}	\N	2026-02-08 03:37:36.561954+00	2026-04-27 01:58:36.600518+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c12277ce-d3cc-42cc-b148-86e27d5943eb	authenticated	authenticated	cliente2pruebaa@gmail.com	$2a$10$TzKi8NBucQwVecCyQWujc.2RdqVaRENZ.P4IPRIWjWPE8XBvjIPQ.	2026-03-11 15:07:38.294198+00	\N		2026-03-11 15:06:22.135108+00		2026-03-11 15:11:07.151586+00			\N	2026-04-27 02:01:50.8584+00	{"provider": "email", "providers": ["email"]}	{"sub": "c12277ce-d3cc-42cc-b148-86e27d5943eb", "email": "cliente2pruebaa@gmail.com", "username": "prueba2", "created_at": "2026-03-11T15:06:22.061Z", "display_name": "prueba2", "email_verified": true, "phone_verified": false}	\N	2026-03-11 15:06:22.101291+00	2026-04-27 02:01:50.879236+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- TOC entry 4498 (class 0 OID 118109)
-- Dependencies: 387
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- TOC entry 4497 (class 0 OID 118086)
-- Dependencies: 386
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- TOC entry 4482 (class 0 OID 17452)
-- Dependencies: 370
-- Data for Name: canciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canciones (id, titulo, artista, url, path, tipo, creado_en, owner, publico) FROM stdin;
c59a4a6a-a15e-4fbe-ba4c-e36b9aed049a	SNAP	Rosa Linn	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/musica/1762536342292_1_-_Rosa_Linn_-_SNAP.mp3	musica/1762536342292_1_-_Rosa_Linn_-_SNAP.mp3	personalizada	2025-11-07 17:25:50.334819+00	\N	t
46eaaedd-5137-4931-8203-49961cd33582	Apartir de hoy 🥹♥️	Te amo 🥹♥️	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/musica/1770858030808_A_partir_de_hoy_-_Maite_Perroni_ft._Marco_di_mauro___max_and_maria___M4A_128K_.m4a	musica/1770858030808_A_partir_de_hoy_-_Maite_Perroni_ft._Marco_di_mauro___max_and_maria___M4A_128K_.m4a	personalizada	2026-02-12 01:00:37.813465+00	\N	t
c5f10ec7-299c-4c08-a546-9f7866cc6cad	Contigo 🥹♥️	Mi amor 🫂♥️	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/musica/1770858588183_Contigo_-_R_o_Roma__Fede_Bracamontes___Mar_a_Alexia__Cover_M4A_128K_.m4a	musica/1770858588183_Contigo_-_R_o_Roma__Fede_Bracamontes___Mar_a_Alexia__Cover_M4A_128K_.m4a	personalizada	2026-02-12 01:09:54.810033+00	\N	t
\.


--
-- TOC entry 4494 (class 0 OID 88895)
-- Dependencies: 383
-- Data for Name: card_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card_logs (id, sender, receiver, created_at) FROM stdin;
\.


--
-- TOC entry 4493 (class 0 OID 88884)
-- Dependencies: 382
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (id, sender, receiver, drawing, created_at) FROM stdin;
\.


--
-- TOC entry 4483 (class 0 OID 17517)
-- Dependencies: 371
-- Data for Name: fotos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fotos (id, titulo, descripcion, url, path, tipo, owner, publico, creado_en) FROM stdin;
a23f1edf-a20e-4c7d-9ba6-b26ba05a0a7b	Mi Dua Perfecta 🫶😍	Eres la mejor compañera para las partidas y para la vida. Gracias por siempre revivirme y por ser el Aniquilador de mi corazón. Te amo ❤️	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1762551448180_1000167514.png	fotos/1762551448180_1000167514.png	foto	\N	t	2025-11-07 21:37:34.945169+00
f8e0caac-2fa0-48bd-a87e-802c5a20219d	La prueba de mi amor infinito ♾️	Y si alguna vez te queda una pequeña duda de lo que siento 🤔, recuerda este corazón late solo por usted es la prueba. Te amo con locura 😍, mi vida🥰	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1763222980746_1000172018.jpg	fotos/1763222980746_1000172018.jpg	foto	\N	t	2025-11-15 16:09:43.866614+00
2f2034c5-855e-487a-884c-0be2044acb65	Mis ojos en ti ❤️	Aunque estemos lejitos, mis ojos y mi corazón siempre estarán puestos en ti, mi amor.❤️\nMirándote y sonriendo 😍	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1763937899450_1000172019.jpg	fotos/1763937899450_1000172019.jpg	foto	\N	t	2025-11-23 22:45:00.880434+00
faf8a917-6a35-450e-b492-f1e3e7e1c73d	Mí amor ❤️	Mí esposito hermoso 🫂❤️	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1765340882401_1001467807.png	fotos/1765340882401_1001467807.png	foto	\N	t	2025-12-10 04:28:03.897037+00
a68297b3-a1cf-4a68-9fc0-234d95ec0497	Te amo con todo mi ser 😍	Te amo❤️te amo❤️te amo❤️te amo❤️te amo❤️te amo\nMuchos besito para mi Rocío 😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1765985135153_1000172021.jpg	fotos/1765985135153_1000172021.jpg	foto	\N	t	2025-12-17 15:25:38.747492+00
e68c4248-2bf8-4ccb-a5c6-f08ccd8e4a57	Te amo ❤️.	Voy a seguir esforzándome para que veas la mejor versión de mí y sepa que te amo solo a tí ❤️.	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1762550673843_1000167507.jpg	fotos/1762550673843_1000167507.jpg	foto	\N	t	2025-11-07 21:24:36.753927+00
db867407-2345-48c7-8f22-335e54e5c863	Mi lugar junto a ti siempre 🥹♥️	No hay nada más bonito que tenerte en mi vida 🫂♥️\nTe amo una eternidad mi esposito hermoso 🫂♥️\nEres toda mi felicidad 🥹♥️	https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/public/archivos/fotos/1776632159566_1000126700.png	fotos/1776632159566_1000126700.png	foto	\N	t	2026-04-19 20:56:03.963344+00
\.


--
-- TOC entry 4484 (class 0 OID 17532)
-- Dependencies: 372
-- Data for Name: mensajes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes (id, autor, texto, privado, referencia_tipo, referencia_id, creado_en, categoria, emoji, nota, user_id) FROM stdin;
707792b8-f31d-424e-aec2-508f4aaf5f0e	Leo	Holaaaaa mi vida :)\nte amo mucho ❤️	f	\N	\N	2025-11-07 17:10:58.328685+00	amor	🌹	You and Me	\N
7eb3f351-2bfe-4a0f-9a7e-b13029ec023a	Leo	Eres lo mas hermoso 😍\nde mis días ✨\ngracias por existir ♥️🫂\neres muy importante para mi,\nTe Amo Mucho ♥️😘	f	\N	\N	2025-11-15 16:20:21.553046+00	triste	❤️		\N
e2032d11-a5db-458f-947d-3cf4f69942f1	Rocío	Mí amor 🥰\nSiento tanta alegría estando a tu lado 🫂❤️\nEres mí refugio y mí paz que tanto espere 🫂❤️\nTe amo demasiado mí Leo 🥹❤️	f	\N	\N	2025-11-17 16:17:20.506538+00	amor	❤️		\N
8e537b74-c241-4760-a78f-736e19fe390b	Leo	Eres mi niña hermosa 😍.        \nEres mi bomboncito 🥰.\nEres mi verdadero amor ❤️.\n\nEn pocas palabras, eres todo para mí.\nEres la mujer que mi corazón amara sin importar que ❤️.\nTu siempre serás la única chica en este mundo a la que amaré con todas las fuerzas de mi corazón 😍😘.	f	\N	\N	2025-12-01 03:48:55.877687+00	amor	💗	Así lo entiendes? O te lo explico a besitos 🥰😘	\N
62b9e8f3-deb2-4110-9e09-f3d078d7c6f7	Rocío	Mí Leo 🥹❤️\nMe siento muy enamorada de ti 🥰🥰\nTe adueñaste de mis pensamientos y de mí corazón ❤️\nMe siento muy feliz de tenerte 🥹❤️\nMe encantas demasiado mí vida ❤️\nCada latido de mí corazón es un te amo para siempre \nNo me imagino una vida sin ti 😓🫂❤️	f	\N	\N	2025-12-05 17:45:08.146288+00	amor	💓	Mí amorcito lindo ❤️	\N
769479cd-80ad-488b-ad66-e7ced14d71c8	Tu esposita 🥹❤️	Mí amorcito lindo 🥰🥰🥰\nEres el mejor novio del mundo 🥹❤️\nSoy muy afortunada de tenerte Leo 🥹❤️\nMe siento muy feliz por estos dos meses, y se que cumpliremos muchos más 😍😍😍\nEres lo que más quiero y amo en la vida 🫂❤️\nEnserio Leo, te amo, te amo, te amo una eternidad \nEres una bendición en mí vida 🫂❤️\nGracias por existir, y por dejarme estar a tu lado 🫂❤️\nLe doy gracias a Dios por dejarme conocerte, eres un hombre increíble ❤️\nEres mí refugio amor mío 🫂❤️\nMí lugar seguro🫂❤️\nTe amo 🫂❤️	f	\N	\N	2025-12-08 10:18:31.872415+00	amor	❤️	Amor de mí vida 🫂❤️	\N
8099772b-5508-42e1-97e1-e86613f585da	Tu esposito  😊💕	💕✨ ¡Mi amor! ✨💕\n¡Hoy celebramos 2 meses de la historia más bonita y mágica que he vivido! 🎉💖 Cada día a tu lado es un regalo precioso que atesoro en mi corazón 🎁❤️\n\n¡Gracias por llenar mi vida de amor infinito, risas  y felicidad absoluta! 😍🌟💫 Eres lo mejor que me ha pasado en la vida y quiero seguir escribiendo nuestra historia juntos, página por página, momento por momento 📖💑✨\n\n¡Te amo infinitamente, Rocío! 💕💕💕 Eres mi todo, mi cielo, mi felicidad completa 🌈☁️💝	f	\N	\N	2025-12-08 15:21:42.9411+00	amor	💝	Con todo mi amor eterno 💖🔥 ¡Felices 2 meses, mi vida! 🎊🎉💕	\N
19d1a524-1b64-4828-bf74-2ead03c7319f	Tu esposita 🥹❤️	Mí esposito hermoso 🥹❤️\nDueño de mí corazón y pensamientos 🥹❤️\nEres el amor de mí vida 🥹❤️\nMí paz y tranquilidad, mí lugar seguro 🫂❤️\nMe siento muy afortunada de tenerte cómo compañero de vida \nQuiero sostener tu mano siempre, estar contigo en las buenas y malas 🫂❤️\nTe amo demasiado mí vida 🫂❤️	f	\N	\N	2025-12-10 04:09:58.419108+00	feliz	❤️	Amorcito de mí vida 🥹❤️	\N
550d5aa7-444a-47ee-933e-b5c0dec41f68	Tu esposita ❤️	Mí niño precioso 😍😍\nYa quisiera que llegue ese día de poder abrazarte y llenarte de besitos 🥹❤️\nMe siento muy enamorada de ti amor 🥹❤️\nAquí ando pensando en ti, cómo todos los días 🥹❤️\nDios me dio el mejor compañero del mundo 🫂❤️\nTe amo demasiado mí Leo precioso 🥹❤️	f	\N	\N	2025-12-11 18:24:53.16634+00	amor	❤️	MÍ esposito hermoso 🫂❤️	\N
f07cec39-6a1f-43bd-820b-a49498ebd8b7	Tu Leo, tu esposito 😘❤️	Mi Rocío hermosa 🥹❤️\nLeer tus palabras aquí me llenó el alma, mi vida.\nEres mi amor, mi paz, mi felicidad y mi lugar seguro 🫂❤️.\nTambién sueño con abrazarte, llenarte de besitos y tenerte cerquita todos los días 🥺❤️.\n\nGracias por elegirme, por amarme así de bonito y por ser mi compañera de vida 🥰✨.\nYo también te elijo hoy y para siempre, mi esposita preciosa 😍❤️🫂	f	\N	\N	2025-12-12 15:36:50.974183+00	amor	💗	Te amo mucho mi Rocío ❤️	\N
f952b34d-05ef-4985-aae9-5d62d3b00191	Tu esposita 🥹❤️	Hola amorcito de mí vida 😍😍😍\nQuiero que sepas que ando pensando en ti 🥹❤️\nY en lo feliz que me siento de tenerte en mí vida 🫂❤️\nEstoy muy enamorada de ti amor mío ❤️\nEres una persona maravillosa ❤️\nMí niño precioso 😍😍😍\nTe amo demasiado mí vida 🫂❤️	f	\N	\N	2025-12-14 18:22:11.872839+00	feliz	🌹	MÍ esposito hermoso 🫂❤️	\N
e2df85df-e3b3-45d3-8790-db930c6bb6d8	Tu esposita ❤️	Mí amorcito lindo 🥹❤️\nTe amo con toda mí alma amor mío 🫂❤️	f	\N	\N	2025-12-17 04:52:11.051449+00	amor	❤️	Mí esposito hermoso 🥹❤️	\N
8ab9e68b-c1f6-4044-a6be-dabf6095c8d6	Tu esposito ❤️	Mi amor hermoso 😍❤️\nMe hace sonreír 🥹💞\nSoy inmensamente feliz de tenerte en mi vida 🫂❤️\nTe amo más de lo que las palabras pueden decir, mí amor eterno 😍❤️ Mí esposita hermosa 🥰❤️	f	\N	\N	2025-12-17 15:40:01.149255+00	amor	❤️	Besitos 😘😘😘😘😘😘😘	\N
7a647d0b-e872-44bf-8951-a23b2f58bc6e	Tu esposita 🥹❤️	Mí amorcito lindo 😍😍😍😍\nTe amo demasiado mí vida 🥹❤️	f	\N	\N	2025-12-20 07:57:33.548736+00	amor	❤️	Mí amor 🥹❤️	\N
9b7db50c-6606-449a-8b10-542ae072e059	Tu esposita 🥹❤️	Me siento muy enamorada y feliz amor mío 🥹❤️\nNo puedo dormir de tanto amor que siento por ti. \nQuisiera poder abrazarte 🥹❤️	f	\N	\N	2025-12-20 07:59:00.683404+00	amor	❤️	Mí niño precioso 😍😍	\N
f39038de-57cb-4344-8f5f-d8808b36b6b9	Tu esposita 🥹❤️	Esté amor que siento por ti, es muy fuerte 🥹❤️\nYo te amo una eternidad mí Leo precioso 🥹❤️	f	\N	\N	2025-12-20 08:01:10.679115+00	amor	❤️	Eres el amor de mí vida 🥹❤️	\N
6e461ce3-1723-4daf-8413-7926ba3666dc	Tu esposita 🥹❤️	😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍	f	\N	\N	2025-12-20 08:03:07.668467+00	amor	❤️	Enamorada de mí esposito hermoso 🥹❤️	\N
8629ac6b-8f34-4777-862b-fd4f259bdd01	Tu esposito 😘❤️	❤️🥰🌹 Mi vida preciosa 💕, cada palabra tuya me llena de alegría 😍✨ y me recuerda lo afortunado que soy 💖. Eres mi paz , mi refugio y mi felicidad 🌟💞. Gracias por elegirme cada día 💘 y por regalarme tanto amor 💝. Prometo cuidarte siempre 💑, con besitos 😘 y abrazos 🤗💞. Te amo con todo mi corazón ❤️, mi esposita hermosa 🌹✨	f	\N	\N	2025-12-20 20:10:35.172951+00	amor	💗	Tu compañero de vida, que nunca dejará de elegirte ❤️	\N
a171530c-89c6-4ba0-a284-28d1e7edee27	leo	te amo mucho amor ❤️❤️❤️🥰🥰🥰🥰😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘	f	\N	\N	2025-12-22 06:29:41.347385+00	feliz	✨	amorrrrr	\N
e26e3e77-03ae-4a7b-81ed-8c295d08530c	Tu esposita 🥰❤️	Te amo una eternidad amor mío 🥹❤️	f	\N	\N	2025-12-24 10:23:26.049294+00	amor	❤️	MÍ esposito hermoso 🫂❤️	\N
59e9ec83-bb0d-4827-a8b2-012682ea89ba	Tu esposito ❤️😘	Esta Navidad 🎄 no pido nada más, porque tenerte en mi vida ya es el regalo más grande ❤️. Gracias por tu amor, tu dulzura y esa forma tan bonita de acompañarme cada día. Aunque hoy la distancia exista 🥺, no apaga lo nuestro al contrario, hace que te piense más y te ame todavía más 🫂✨. Mi corazón siempre camina contigo.\nFeliz Navidad🎄🎉, mi Rocío ❤️	f	\N	\N	2025-12-25 02:58:13.493247+00	amor	❤️	Te amo mucho mi esposita hermosa 🥺❤️	\N
f27018f8-6f78-4937-ab6e-3557f2d769e1	Tu esposita ❤️	Mí amorcito lindo 🥹❤️\nQue bonitas palabras las que me dices, siento tu amor en mí corazón\nMe siento muy enamorada de ti amor mío 🫂❤️\nSoy muy afortunada de tenerte mí vida 🫂❤️\nMe encanta tu forma de amarme, me haces muy feliz \nQuisiera poder abrazarte y decirte lo mucho que te amo y lo feliz que me haces \nEres el mejor novio del mundo 🫂❤️\nMí persona favorita, eres muy importante para mí \nNo quiero estar nunca sin ti amor 🫂❤️\n\nFeliz navidad mí vida 🫂❤️	f	\N	\N	2025-12-25 11:27:40.55472+00	amor	❤️	Mí esposito hermoso 🫂❤️	\N
4efe8d36-33f5-46de-a290-2a6a563a5c27	Tu esposita ❤️	Mí esposito hermoso 🥹❤️	f	\N	\N	2025-12-26 17:04:12.781174+00	amor	💓	Te amo demasiado mí vida 🫂❤️	\N
911ef1fb-7806-44f3-baa0-327af4e5261a	Tu esposito ❤️	Amorrr tuuuuuu no tienes ideaaaaaaaa de lo mucho que te extrañooooo🥺❤️ y lo muchoooooo que quieroooooooo un abrazoooooooo tuyoooooo ahoraaaaaaaaa mi esposita hermosa 🥰❤️🫂	f	\N	\N	2025-12-28 18:47:48.812093+00	amor	🌹	Te amooo mi vida ❤️	\N
b5891512-233b-4b74-bfd7-227982987755	Tu esposita 🥹♥️	Amorcito de mi vida 🥹♥️\nYo quiero abrazarte muy fuerte y decirte lo mucho que te amo 🥹♥️\nEres el amor de mi vida 🥹♥️	f	\N	\N	2025-12-29 04:27:12.218832+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
4c770ab8-ac58-4151-9155-9ee093e8680e	Tu esposito 🥰	Este nuevo año llega lleno de sueños ✨ y el más bonito eres tú ❤️\nGracias por tu amor, tu ternura y por caminar conmigo incluso en los días difíciles 🫂❤️\nQue este año nos regale más momentos, más sonrisas 😊 y más razones para seguir eligiéndonos 🫂\nFeliz Año Nuevo, mi Rocío bella 🥰😍	f	\N	\N	2026-01-01 04:09:41.599682+00	amor	💗	Mi esposita hermosa 😍❤️	\N
df45c163-c975-4d44-b052-8b4965f7f89e	Tu esposita 🥹♥️	Mi amorcito lindo ♥️\nMe siento muy feliz de comenzar el año teniéndote a ti en mi vida 🫂♥️\nEres lo mejor que me ha pasado \nQuiero sostener tu mano siempre mi vida 🫂♥️\nCambiaste mi vida por completo, nunca me sentí tan feliz cómo lo soy desde que te conocí 🫂♥️\nTe amo una eternidad mi amor ♥️	f	\N	\N	2026-01-01 23:14:54.581232+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
4bf48467-b269-4a26-b073-9018f8003f86	Tu esposita 🥹♥️	Mi amorcito lindo 🥹❤️\nMi amor eterno 🥹❤️\nTe amo demasiado mi vida 🫂❤️	f	\N	\N	2026-01-06 05:28:26.319331+00	amor	❤️	Mi esposito hermoso 🥹❤️	\N
42c4bf83-adc8-495b-8003-49fbdfa8fd38	Tu esposito 😘	Hay momentos con dudas, inseguridades, silencios y días que no son tan buenos 🫂❤️ también aparecen problemas y personas que quieren meterse en lo nuestro. Aun así, contigo quiero superar todo lo que se cruce en nuestro camino  cumplir lo que nos prometemos, crecer juntos y seguir de la mano 👩‍❤️‍👨. Eres lo que elijo hoy y siempre 🥹❤️	f	\N	\N	2026-01-07 02:34:03.193919+00	motivacion	🌹	Mi esposita hermosa 🥰❤️	\N
fd7868fa-7e63-431f-a5f4-af4867c81235	Tu esposita 🥹♥️	Hola mi esposito hermoso 🥹♥️\nDiscúlpame por no haberme tomado un tiempo para responderte 😓\nCreeme que te pienso en cada momento aunque esté ocupada \nTe amo demasiado mi vida, también quiero sostener tu mano, y superar todo lo que se nos cruce.\nEres la persona con la cuál quiero estar siempre, y me siento muy feliz de tenerte amor mío.\n\nSoy muy afortunada de tener un gran hombre a mi lado 🫂♥️	f	\N	\N	2026-01-09 10:48:58.447633+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
c1518909-c39d-4912-89d8-a41b2fd35f31	Tu esposito ❤️🥰	Amarte no es solo para los días bonitos ❤️, también te amo en los días cansados, cuando cuesta hablar o entendernos. Amarte es elegirte cada día ❤️🫂, con tus virtudes, tus miedos y tus sueños. Contigo aprendí que el amor es cuidar, respetar y crecer juntos 👩‍❤️‍👨. Y eso es lo que quiero contigo tomar tu mano 🥰, superar todo lo que venga y construir una vida de la que nos sintamos orgullosos 🥹❤️.	f	\N	\N	2026-01-15 03:12:23.995912+00	amor	💓	Te amo ❤️ mi esposita hermosa 🥰❤️	\N
7536f367-e6f2-4a9a-8ef7-3e4f41e7fb93	Tu esposita 🥹♥️	Mi amor 🥹♥️\nTe amo en cada momento, te amo con toda mi alma 🫂♥️\nGracias por elegirme cada día y por todo el amor que me das.\nMe haces muy feliz 🥹♥️\nEres la persona con la cuál quiero estar el resto de mi vida 🫂♥️	f	\N	\N	2026-01-15 12:39:16.770568+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
58bc5e87-6dd4-494e-8ac7-1e1367b96440	Tu esposito 🥰❤️	Mi vida 🥺\nQuisiera decirte que me encantas, pero sería mentirte… 🙃\nporque no es solo encanto lo que siento por ti ♥️\n\nMe fascinas en cada detalle, me apasiona tu forma de ser ❤️‍🔥\ny sin darme cuenta te adueñaste de mis pensamientos 😶‍🌫️\n\nDecir que me encantas se queda corto,\nporque la verdad es que me enloqueces bonito 🥹💖\nme aceleras el corazón ❤️🔥y haces que sonría sin razón 😊\n\nNo eres solo alguien que me gusta,\neres alguien que despierta algo muy profundo en mí 🫂❤️	f	\N	\N	2026-01-20 02:51:30.991537+00	amor	❤️	Te amo, mi esposita hermosa 🥰❤️🫂	\N
d7c6909c-a7db-41e1-930f-83e418a76391	Tu esposita 🥹♥️	Mi amor 🥹♥️\nQue bonito lo que me dices 🥹♥️\nMe sonrojas y me haces muy feliz 😅♥️\nTE AMO DEMASIADO AMOR MÍO 🫂♥️\nMe llenas el alma de amor y de felicidad 🥹♥️\n😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍	f	\N	\N	2026-01-21 04:19:34.410159+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
82348afa-614f-4b8e-9666-c5f38e64edc6	Tu esposita 🥹♥️	Mi esposito hermoso 🥹♥️\nTe amo demasiado mi vida 🫂♥️	f	\N	\N	2026-01-26 04:05:37.970873+00	amor	❤️		\N
80f157eb-4c2f-4a6f-b0b6-337543882937	Tu esposito ❤️😘	Mi esposita hermosa 🥹❤️. Muchos besitos para usted amor 🥰❤️😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘TE AMO MUCHÍSIMO MI ROCÍO BELLA 😍😍❤️	f	\N	\N	2026-01-26 15:15:51.066649+00	amor	❤️	Mi esposita 🥰❤️	\N
edb8d2d9-d170-4dee-91bf-c6d23a0d8723	Tu esposita 🥹♥️	Adoro tus besitos mi amor 😍😍😍😍😍😍\nTe amo mucho mi vida 🥹♥️	f	\N	\N	2026-01-27 03:17:39.667041+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
b8e8ae65-3569-4278-8621-c5c4ef42327c	Tu esposita 🥹♥️	Mi amorcito lindo 🥹♥️\nEres mi persona favorita 🫂♥️\nLa persona que alegra mis días y le da sentido a mi vida 🫂♥️\nTe amo mi esposito hermoso 🫂♥️\nGracias por estar siempre a mi lado 🫂♥️	f	\N	\N	2026-02-05 04:50:30.017129+00	amor	❤️	Mi esposito hermoso 🥹♥️	\N
7c56b3fd-7a36-4684-b526-dc34c7a1de64	Tu esposito 🥰❤️	Mi vida 🥹❤️\nLa distancia no me quita las ganas de estar contigo ❤️, solo hace crecer el anhelo por el día en que por fin estemos juntos 🥹🫂. Hoy celebramos 4 meses de amor ❤️, paciencia  y sueños compartidos . Gracias, Rocío, por elegirme cada día . Cada día a tu lado es una bendición ❤️🫂\nTe amo muchísimo mi vida 🥰❤️	f	\N	\N	2026-02-09 00:40:49.171896+00	amor	❤️	Mi esposita hermosa 🥹🥰	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
49ed8137-1878-4f22-9b6e-1b0f3658177b	Tu esposita 🥹♥️	Mi esposito hermoso 🥹♥️\nMi compañero de vida 🫂♥️\nTe amo demasiado amor mío 🥹♥️\nGracias por dejarme estar a tu lado siempre 🥹♥️	f	\N	\N	2026-02-12 00:57:25.95609+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
8366576c-8667-467b-82cc-dcc3b3b563c4	Tu esposita 🥹♥️	Mi amorcito lindo 🥹❤️\nHoy es nuestro primer San Valentín juntos 🥹❤️\nMe siento muy feliz de tenerte en mi vida 🫂❤️\nGracias por estar a mi lado siempre 🫂❤️\nY por todo el amor bonito que me das todos los días 🥹❤️\nSoy muy afortunada de tener un gran hombre cómo tú  a mí lado 🥹❤️\nMi compañero de vida 🫂❤️\nMi mejor amigo 🥹❤️\nMe siento muy enamorada de ti mi amor 🥹❤️\nFELIZ DÍA DE SAN VALENTÍN MI AMOR 😍❤️	f	\N	\N	2026-02-14 14:22:15.163309+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
15512f5e-da8a-4ae1-a525-6b63cc025297	Tu esposito que ama una eternidad 🥹❤️	Mi vida 🥹❤️\nNuestro primer San Valentín juntos y espero que sea el primero de muchos más a tu lado 🫂❤️\nGracias por amarme tan bonito y por hacerme sentir el hombre más afortunado del mundo.\nTú eres mi mejor amiga, mi compañera y mi lugar seguro 🥹❤️\nMe encanta construir este amor contigo, paso a paso, con sinceridad y confianza.\nTambién estoy profundamente enamorado de ti, Rocío ❤️\nFeliz Día de San Valentín, mi vida 🫂❤️	f	\N	\N	2026-02-14 15:09:33.459263+00	amor	❤️	Mi esposita hermosa 🥰❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
02575c90-8dd5-4521-b767-a1151321ce3f	Tu esposita 🥹♥️	Mi esposito hermoso 🥹❤️\nTe amo con toda mi alma amor mío 🥹❤️\nTus palabras me abrazan el alma, y puedo sentir todo el amor que me das 🥹❤️\nMe haces muy feliz mi vida 🫂❤️\nTambién me encanta construir este amor tan bonito junto a ti 🫂❤️\nGracias por todo el amor que me das siempre 🥹❤️	f	\N	\N	2026-02-15 03:19:17.934949+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
f047e3ef-974d-401b-bba0-5f8d3715f5a4	Tu esposito ❤️😘	Amor mío ❤️🥹, eres la melodía suave que acompaña mis días y el pensamiento que dibuja sonrisas en mi rostro sin avisar 😉😍 Me inspiras a ser mejor, a creer más y a soñar en grande. En cada latido va tu nombre guardado como un tesoro eterno ❤️🫂. Gracias por existir, por tu ternura infinita y por el amor tan sincero que me regalas. Quiero cuidarte, valorarte y elegirte siempre 🌹. Eres mi alegría constante, mi ilusión más bonita y el lugar donde mi corazón quiere quedarse ❤️\nTe amo Rocío 🥹❤️	f	\N	\N	2026-02-19 20:23:31.337037+00	nostalgia	❤️	Mi esposita hermosa ❤️🥰	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
bee9afbf-b9b4-4684-9988-4840f3e2dffc	Tu esposita 🥹♥️	Hola mi amor 🥺♥️\nQue bonito lo que me dices, palabras llenas de amor, que me llegan al corazón, y me haces muy feliz 🥹♥️\nTe amo demasiado mi vida 🫂♥️\nGracias por amarme cómo lo haces 🥹♥️\nTambién quiero cuidarte, valorarte y elegirte siempre 🫂♥️	f	\N	\N	2026-02-23 04:26:47.322262+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
5b08cfd5-f864-4091-a853-205a45540ff6	Tu esposita 🥹♥️	Mi amor 🥺♥️\nTe amo demasiado mi vida 🫂♥️	f	\N	\N	2026-02-26 21:06:25.29699+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
bb1ff8a2-ffa9-44b7-a330-6ef198e00618	Tu esposito ❤️😘	Mi vida 🥺❤️\nHe leído muchas historias y soñado con finales felices, pero nada me emociona más que la vida que escribo contigo 😍❤️\nNo necesito mundos perfectos ni héroes imaginarios me basta mirarte, pensante y saber que mi mejor capítulo es a tu lado 🌹❤️\nNuestro destino se construye cada día, cuando tú me eliges y yo te elijo a ti 🫂❤️\nTe amo mucho mí Rocío hermosa 🥰❤️\n😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘	f	\N	\N	2026-03-04 16:29:27.97499+00	amor	❤️	Mi esposita hermosa 🥺❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
2ac047b3-54d1-42d0-8513-45f904641330	Tu esposito ❤️😘😘	Hoy cumplimos 5 meses juntos ❤️🥰 y cada día a tu lado se volvió algo muy especial para mí ❤️. Gracias por llegar a mi vida y por hacer que incluso los días normales se sientan diferentes cuando estoy contigo 🌹❤️.\nEn este tiempo aprendí a quererte más de lo que imaginaba ❤️, a disfrutar cada momento 😅 y cada conversación contigo ❤️🫂. Me encanta lo que estamos construyendo juntos 🫶.\nFelices 5 meses, mi amor ❤️😘. Te amo muchísimo mí Rocío hermosa ❤️🫂	f	\N	\N	2026-03-08 23:05:18.686413+00	amor	❤️	Mí esposita hermosa 🥰❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
491838fb-4ec9-4686-b967-227e061bd6c0	Tu esposita 🥹♥️	Mi compañero de vida 🫂♥️\nTe amo con toda mi alma mi amorcito lindo 🫂♥️\nEres lo que más amo en la vida 🫂🥺♥️\nLe doy gracias a Dios por haberte conocido y tenerte en mi vida 🫂♥️	f	\N	\N	2026-03-13 03:19:23.03463+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
10829d6f-9b3b-4a13-add6-da5ea7a4a9e9	Tu esposita 🥹♥️	Hola mi amor 🥺♥️\nTe amo con toda mi alma mi esposito hermoso 🫂♥️\nGracias por estar a mi lado siempre 🫂♥️	f	\N	\N	2026-03-17 04:11:56.659135+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
af8af0e9-c41d-464b-8519-2b8f8156175e	Tú esposito 🥰❤️	Mí esposita hermosa 😍😍😍😍🥰❤️\nTe amo muchísimo mí Rocío hermosa 😍❤️🥰😘😘😘😘😘🌹	f	\N	\N	2026-03-23 03:12:29.031381+00	amor	❤️	Mí esposita hermosa 🥹❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
a386ca3c-0590-42c5-816f-cba861b8fc7e	Tu esposita 🥹♥️	Mi esposito hermoso, bello, guapo, precioso 😍😍😍😍😍\nTe comería a besitos a cada segundo 🥹♥️\n😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘\nTe amo demasiado mi vida 🥹♥️	f	\N	\N	2026-03-27 03:24:22.738394+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
db576f1b-346c-4d36-949f-7d9bcd8f9110	Tú esposito 🥰❤️	Mí Rocío a tu lado aprendí que el amor no se mide en distancia, sino en todo lo que sentimos cada día 🫂❤️\nEres mi lugar favorito, mi paz y mi alegría 🥺❤️\nContigo, incluso lo más simple se vuelve especial ❤️\nGracias por existir y por elegir quedarte conmigo ❤️\nTe amo, hoy y siempre ❤️	f	\N	\N	2026-04-02 05:42:16.646058+00	amor	🌹	Mí esposita hermosa 🥹❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
406909e0-17f2-4375-a8a6-eac118b7d416	Tu esposita 🥹♥️	Mi amorcito lindo 🥹♥️\nTe amo demasiado mi vida 🫂♥️\nTu también eres mi lugar favorito, mi paz y mi alegría 🥹♥️\nMe siento muy feliz y afortunada de tener un gran hombre a mi lado 🥹♥️\nMi compañero de vida 🫂♥️	f	\N	\N	2026-04-02 18:53:57.949803+00	amor	💕	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
56bda363-7240-400f-83a8-cf9284311c5f	Tú esposito que te adora una eternidad 🥰❤️	Feliz aniversario mí vida ❤️👩‍❤️‍👨🌹\nYa tenemos medio año juntos 🥺❤️\nAún me cuesta creer que te encontré. En este tiempo lograste tocar mi corazón y mi alma de una forma única ❤️\nHemos vivido tanto, y sé que aún nos queda mucho por escribir juntos 🫂❤️\nGracias por estos 6 meses tan bonitos, por estar en cada momento y hacerme tan feliz 🥰\nEsto recién comienza…\nTe amo, mi vida ❤️	f	\N	\N	2026-04-08 17:40:13.262972+00	amor	❤️	Mí esposita hermosa 🥹❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
cf420bdc-24d0-417f-9d54-896ea937ceb1	Tu esposita 🥹♥️	Feliz aniversario mi amor 🥹❤️\nLos mejores 6 meses en toda mi vida 🥰♥️\nCada momento a tu lado es un regalo que atesoro en mi corazón 🫂♥️\nQuiero estar a tu lado por el resto de mi vida, apoyándote, amándote, siendo tu compañera de vida, tu confidente, tu mejor amiga🫂♥️ \nTu eres mi todo 🥹♥️\nTe amo por ser tú, por hacerme sentir amada y feliz 🥰\nTe amo más de lo que las palabras pueden expresar, más de lo que puedo imaginar 🥹❤️\nVamos a seguir construyendo nuestra historia juntos mi amor 🫂♥️	f	\N	\N	2026-04-08 19:01:52.466829+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
37047367-e24d-467f-b89c-f7973474b8ed	Tu esposita 🥹♥️	Mi amor 🥹♥️\nTe amo demasiado mi vida 🫂♥️	f	\N	\N	2026-04-15 03:37:23.301492+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
a2135f9e-2a7f-44fd-aaa3-bcfb2b245041	Tu esposito 🥰❤️	Mí Rocío hermosa 😍😍😍❤️\nTe amo muchísimo mí vida 🥹❤️🫂\nMuchos besitos para ti mi amor 😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘 \nUnos abrazos llenos de amor ❤️🫂❤️🫂❤️🫂❤️🫂\nY una rosas igual de hermosa que usted mi vida 🥹😍🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹\nTe amo muchísimo mí esposita hermosa 🥹❤️🫂	f	\N	\N	2026-04-15 14:04:43.630118+00	amor	🌹	Mí esposita hermosa 🥹❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
bc38d709-3f31-4da6-947c-4cc9d3d099c5	Tu esposita 🥹♥️	Mi amorcito lindo 🥹♥️\nTe amo demasiado mi vida 🫂♥️\nGracias por todo el amor que me das siempre, y por hacerme muy feliz 🥺♥️\nMi compañero de vida 🫂♥️	f	\N	\N	2026-04-20 02:59:20.708472+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
2c2d81ef-c8fd-4181-95b4-732e349629cb	Tu esposita 🥹♥️	Hola mi amor 🥰♥️\nSon las 14:42 hs de tu país 😅\nAmorcito te extraño mucho 🥺\nYa quiero que pase la hora rápido para llenarte de besos 🥺♥️\nTe amo demasiado mi vida 🫂♥️	f	\N	\N	2026-04-23 18:45:23.07911+00	amor	❤️	Mi esposito hermoso 🥹♥️	0a4d4080-3cc7-46c0-833b-cc2179b9896c
25427bf2-5da2-4194-9f03-c7438297c445	Tu esposito 🥰❤️	Mí esposita hermosa 🥺❤️\nTe amo muchísimo mí vida 🥰❤️👩‍❤️‍👨	f	\N	\N	2026-04-25 01:30:12.219832+00	amor	❤️	Mí esposita hermosa 🥹❤️	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
\.


--
-- TOC entry 4488 (class 0 OID 47508)
-- Dependencies: 376
-- Data for Name: reacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reacciones (id, mensaje_id, emoji, creado_en, session_id, user_id) FROM stdin;
1aa76ba5-5b7c-405c-b086-72abbce7245f	edb8d2d9-d170-4dee-91bf-c6d23a0d8723	❤️	2026-01-29 03:54:28.086277+00	b99833a6-6305-4972-bd19-9fc253e80bcc	\N
79883c8a-d79e-4869-86ec-902c91093eb4	82348afa-614f-4b8e-9666-c5f38e64edc6	❤️	2026-02-09 00:41:34.964064+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
288bae4b-03b6-4590-9f16-4f0f5e8bceca	d7c6909c-a7db-41e1-930f-83e418a76391	❤️	2026-02-09 00:41:39.911818+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
d1770e30-e854-4531-8b54-8b0c6e3bfbec	7536f367-e6f2-4a9a-8ef7-3e4f41e7fb93	❤️	2026-02-09 00:41:49.062839+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
f9dc90f7-13c5-49c2-8732-81ffd852711b	7c56b3fd-7a36-4684-b526-dc34c7a1de64	😍	2026-02-12 00:58:40.586977+00	0a4d4080-3cc7-46c0-833b-cc2179b9896c	\N
80bf67fd-1a9c-49ff-967e-409d741678c9	b8e8ae65-3569-4278-8621-c5c4ef42327c	🥹	2026-02-12 00:58:54.274439+00	0a4d4080-3cc7-46c0-833b-cc2179b9896c	\N
e76788a7-399c-4cd3-9f8b-f963054528f1	49ed8137-1878-4f22-9b6e-1b0f3658177b	🥹	2026-02-14 05:27:18.256478+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
695d7ee3-05bf-4a90-8b37-720f9c563ade	8366576c-8667-467b-82cc-dcc3b3b563c4	❤️	2026-02-14 15:09:51.568559+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
4560751b-04d0-4d6b-b857-42b853ea0bcf	02575c90-8dd5-4521-b767-a1151321ce3f	😍	2026-02-16 01:43:25.07584+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
f8618c11-a68b-422f-a5a4-b6b379ad4980	fd7868fa-7e63-431f-a5f4-af4867c81235	🫂	2026-02-20 21:38:40.110572+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
d949b131-16eb-466f-8b01-db54f3e0bafd	4bf48467-b269-4a26-b073-9018f8003f86	❤️	2026-02-20 21:39:24.270385+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
b7a97a99-1033-40eb-9564-39673eeb2df9	df45c163-c975-4d44-b052-8b4965f7f89e	🥹	2026-02-20 21:39:57.028205+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
bae9293a-e1e1-4105-8182-955718515a63	b5891512-233b-4b74-bfd7-227982987755	❤️	2026-02-20 21:40:31.673789+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
701de273-4fb4-46d6-8f0f-71d9191d4b5f	4efe8d36-33f5-46de-a290-2a6a563a5c27	😍	2026-02-20 21:41:13.399938+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
4b99a72f-289f-40c8-abd8-e4a5eccbb26f	f27018f8-6f78-4937-ab6e-3557f2d769e1	🫂	2026-02-20 21:41:27.409004+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
61a5c66c-7785-4473-bb17-282fa6238de9	e26e3e77-03ae-4a7b-81ed-8c295d08530c	❤️	2026-02-20 21:42:02.065952+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
5b0bb115-8614-41b0-844d-9b01b0269ae2	6e461ce3-1723-4daf-8413-7926ba3666dc	😍	2026-02-20 21:42:10.638649+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
852e32c3-565b-4639-bc51-a6493ecd1278	f39038de-57cb-4344-8f5f-d8808b36b6b9	🥹	2026-02-20 21:42:25.105938+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
049effdc-6c8e-45c4-9771-6e138adb9f27	9b7db50c-6606-449a-8b10-542ae072e059	🫂	2026-02-20 21:42:41.47879+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
1b828567-421e-4e99-b945-35aef8041dcc	7a647d0b-e872-44bf-8951-a23b2f58bc6e	❤️	2026-02-20 21:42:49.67607+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
37ca1a0a-25e2-43f2-8a6d-d47fdadb7ca6	e2df85df-e3b3-45d3-8790-db930c6bb6d8	❤️	2026-02-20 21:43:25.48523+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
722902c9-b809-43a2-b69c-efcac4d9bc10	f952b34d-05ef-4985-aae9-5d62d3b00191	❤️	2026-02-20 21:43:34.613679+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
cb53a216-f0bf-4250-8781-448b5ec822f6	550d5aa7-444a-47ee-933e-b5c0dec41f68	❤️	2026-02-20 21:43:49.151081+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
fff6e906-25f6-4bac-902e-e520727f7ccd	19d1a524-1b64-4828-bf74-2ead03c7319f	❤️	2026-02-20 21:44:02.524047+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
e767c506-4c5f-477d-ae44-4d0132061e96	769479cd-80ad-488b-ad66-e7ced14d71c8	❤️	2026-02-20 21:44:16.411679+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
dfe8b155-aa4c-4078-a2cc-5c0025b9e229	62b9e8f3-deb2-4110-9e09-f3d078d7c6f7	🥹	2026-02-20 21:44:30.490363+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
57127b8d-413c-4594-a6ae-df505b6cd2e6	e2032d11-a5db-458f-947d-3cf4f69942f1	❤️	2026-02-20 21:44:41.510337+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
056b4929-fbb7-4381-a701-46e427f7931c	bee9afbf-b9b4-4684-9988-4840f3e2dffc	🥹	2026-02-24 17:23:50.565085+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
43725edd-fce4-4fb4-994d-c49ebe858dab	5b08cfd5-f864-4091-a853-205a45540ff6	❤️	2026-03-04 16:29:39.56026+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
4741661e-5a3a-4c43-8b2d-ff4d582338a5	a386ca3c-0590-42c5-816f-cba861b8fc7e	❤️	2026-04-08 17:40:45.480437+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
577477a1-eccc-421d-904d-8ac8d8c2cd75	491838fb-4ec9-4686-b967-227e061bd6c0	❤️	2026-04-08 17:40:50.361629+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
60476060-9d6f-419a-8854-48647fb14fbf	cf420bdc-24d0-417f-9d54-896ea937ceb1	❤️	2026-04-15 14:00:27.288842+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
4813baa7-a2e7-4891-833f-9ef59d68daf4	10829d6f-9b3b-4a13-add6-da5ea7a4a9e9	❤️	2026-03-23 03:12:44.235079+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
06cba80c-94fa-4c51-88eb-f562cac43b53	406909e0-17f2-4375-a8a6-eac118b7d416	❤️	2026-04-08 17:40:38.968635+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
96461246-27e9-4e9e-840d-9500faa93494	37047367-e24d-467f-b89c-f7973474b8ed	❤️	2026-04-15 14:00:38.23495+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
079de933-fa46-47e2-981e-0646565fc8bb	2c2d81ef-c8fd-4181-95b4-732e349629cb	❤️	2026-04-25 01:30:36.114286+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
42b61afd-cb37-471c-b84e-f79117cf7c16	bc38d709-3f31-4da6-947c-4cc9d3d099c5	❤️	2026-04-25 01:30:49.255518+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	\N
\.


--
-- TOC entry 4495 (class 0 OID 88905)
-- Dependencies: 384
-- Data for Name: shared_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_cards (id, sender, receiver, drawing, quote_index, created_at) FROM stdin;
\.


--
-- TOC entry 4490 (class 0 OID 72907)
-- Dependencies: 378
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profiles (id, user_id, username, email, created_at, updated_at) FROM stdin;
7	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	leonardo	leonardopenaanez@gmail.com	2026-02-08 03:37:47.802+00	2026-02-08 03:37:39.397109+00
8	0a4d4080-3cc7-46c0-833b-cc2179b9896c	rocio	rociomilagros268@gmail.com	2026-02-08 04:26:59.911+00	2026-02-08 04:27:00.842148+00
9	ad47de29-35ee-429a-b7aa-e1813cbf0b05	cliente1	clientebot6001@gmail.com	2026-02-09 00:13:03.335+00	2026-02-09 00:13:04.524575+00
10	c12277ce-d3cc-42cc-b148-86e27d5943eb	prueba2	cliente2pruebaa@gmail.com	2026-03-11 15:06:24.61+00	2026-03-11 15:06:24.62802+00
\.


--
-- TOC entry 4492 (class 0 OID 86549)
-- Dependencies: 381
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, user_id, email, role, created_at, updated_at, updated_by) FROM stdin;
6b86c43a-892c-4b11-9196-092e7062752b	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f	leonardopenaanez@gmail.com	super_admin	2026-02-08 23:40:38.322502+00	2026-02-09 00:08:05.31+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
b3e1e0b1-ebf6-45da-8b3d-e7be13f6d199	0a4d4080-3cc7-46c0-833b-cc2179b9896c	rociomilagros268@gmail.com	admin	2026-02-08 04:26:58.154679+00	2026-02-10 17:29:59.369+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
baeb2143-5a44-48c1-be7f-d2ace7642626	ad47de29-35ee-429a-b7aa-e1813cbf0b05	clientebot6001@gmail.com	admin	2026-02-09 00:13:01.538345+00	2026-02-11 20:14:34.24+00	71ca4c2d-1c75-4b9e-a854-fa996aa06f6f
acbd27bf-ae65-4def-bd20-6aafc0184e95	c12277ce-d3cc-42cc-b148-86e27d5943eb	cliente2pruebaa@gmail.com	invitado	2026-03-11 15:06:22.100936+00	2026-03-11 15:06:22.100936+00	\N
\.


--
-- TOC entry 4491 (class 0 OID 76374)
-- Dependencies: 379
-- Data for Name: visitor_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visitor_logs (id, visitor_id, "timestamp", ip_publica, ip_local, isp, asn, pais, codigo_pais, region, ciudad, codigo_postal, latitud, longitud, zona_horaria, navegador, sistema_operativo, plataforma, tipo_dispositivo, es_movil, user_agent, resolucion_pantalla, profundidad_color, nucleos_cpu, memoria, idioma, idiomas, cookies_habilitadas, dnt, canvas_fp, webgl_vendor, webgl_renderer, fingerprint_unico, url_actual, url_referrer, datos_completos, created_at, distrito, conexion_tipo, organizacion, gps_latitud, gps_longitud, gps_precision, gps_altitud, gps_velocidad, gps_estado) FROM stdin;
e0d73628-4b4c-48ad-96d9-ff6f2718fb10	visitor_1769658808930_t85qo9fko	2026-01-29 03:53:30.433+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T03:53:30.433Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769658808930_t85qo9fko", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 03:53:30.29254+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
04932af1-508b-4512-8f9b-3ed2538291f8	visitor_1769658824777_roxbt5rsa	2026-01-29 03:53:45.457+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T03:53:45.457Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769658824777_roxbt5rsa", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 03:53:45.009532+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
f260d688-bedc-47fc-8a87-31abdfcfe2f5	visitor_1769659216302_uoekusa2a	2026-01-29 04:00:19.695+00	2800:320:4b3a:5d00:6130:ca1a:ece2:9ba7	\N	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "es-US", "region": "La Paz Department", "idiomas": ["es-US", "es-419", "es"], "latitud": -16.5, "memoria": "8GB", "es_movil": false, "ip_local": null, "longitud": -68.15, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T04:00:19.695Z", "ip_publica": "2800:320:4b3a:5d00:6130:ca1a:ece2:9ba7", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769659216302_uoekusa2a", "codigo_pais": "BO", "nucleos_cpu": 16, "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-01-29 04:00:17.396338+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
eee06ed6-dedc-4eb5-b041-f90dc989a4d7	visitor_1769659232968_ibk97f4p2	2026-01-29 04:00:35.378+00	2800:320:4b3a:5d00:6130:ca1a:ece2:9ba7	\N	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "es-US", "region": "La Paz Department", "idiomas": ["es-US", "es-419", "es"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": null, "longitud": -68.15, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-01-29T04:00:35.378Z", "ip_publica": "2800:320:4b3a:5d00:6130:ca1a:ece2:9ba7", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1769659232968_ibk97f4p2", "codigo_pais": "BO", "nucleos_cpu": 16, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-01-29 04:00:32.98464+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
9ff8b0e4-8631-4d64-baa0-5de88d5bfdbe	visitor_1769749281317_c4myhu2vf	2026-01-30 05:01:27.85+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US,en,es}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	android-app://com.google.android.googlequicksearchbox/	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US", "en", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:01:27.850Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769749281317_c4myhu2vf", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "android-app://com.google.android.googlequicksearchbox/", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:01:27.681234+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
352b0a3c-5960-4aae-9e78-51132f49159f	visitor_1769749294795_zz8wcf7eg	2026-01-30 05:01:38.52+00	200.87.246.136	\N	EMPRESA NACIONAL DE TELECOMUNICACIONES SOCIEDAD ANONIMA	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv8l	Móvil	t	Mozilla/5.0 (Linux; Android 15; SM-S901B Build/AP3A.240905.015.A2; ) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/140.0.7339.119 Mobile Safari/537.36 MetaIAB	360x780	32	8	8GB	es-US	{es-US,es}	t	0	tTbhEIkICEFWDpGlkErBL4f1xLltMCSc1wAAAAAElFTkSuQmCC	Qualcomm	Adreno (TM) 630	4unk4y	https://leolpa000.github.io/OurCorner/	https://www.google.com/	{"asn": null, "dnt": "0", "isp": "EMPRESA NACIONAL DE TELECOMUNICACIONES SOCIEDAD ANONIMA", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "tTbhEIkICEFWDpGlkErBL4f1xLltMCSc1wAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-01-30T05:01:38.520Z", "gps_estado": "Obtenido", "ip_publica": "200.87.246.136", "plataforma": "Linux armv8l", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; SM-S901B Build/AP3A.240905.015.A2; ) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/140.0.7339.119 Mobile Safari/537.36 MetaIAB", "visitor_id": "visitor_1769749294795_zz8wcf7eg", "codigo_pais": "BO", "gps_altitud": null, "gps_latitud": -16.4991, "nucleos_cpu": 8, "gps_longitud": -68.1363, "organizacion": "EMPRESA NACIONAL DE TELECOMUNICACIONES SOCIEDAD ANONIMA", "url_referrer": "https://www.google.com/", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 1000, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 630", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "4unk4y", "profundidad_color": 32, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "360x780"}	2026-01-30 05:01:39.189303+00	Andrés Ibáñez Province	\N	EMPRESA NACIONAL DE TELECOMUNICACIONES SOCIEDAD ANONIMA	-16.4991000	-68.1363000	1000	\N	\N	Obtenido
cc23327f-337f-41d4-a11d-3895f3ef4aa9	visitor_1769659961132_q83os92pb	2026-01-29 04:12:42.414+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T04:12:42.414Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769659961132_q83os92pb", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 04:12:42.213946+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
c3e2bc47-5396-4914-8ba8-0f58df286088	visitor_1769659980454_l86d3thm2	2026-01-29 04:13:00.99+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T04:13:00.990Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769659980454_l86d3thm2", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 04:13:00.51225+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
f81d6d97-9eec-4c3d-8469-370ca9f99f26	visitor_1769702034268_zso05ytnb	2026-01-29 15:53:56.29+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T15:53:56.290Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769702034268_zso05ytnb", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 15:53:56.066078+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
1330f828-85f7-4373-8968-5e4429043045	visitor_1769702050437_fzwctjpvy	2026-01-29 15:54:11.111+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T15:54:11.111Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769702050437_fzwctjpvy", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 15:54:10.700264+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
08f42fea-1dd1-4e37-9240-0bd3c60a0dd4	visitor_1769702061856_okqbzi5st	2026-01-29 15:54:22.434+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T15:54:22.434Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769702061856_okqbzi5st", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 15:54:21.999992+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
19c338ad-7e0e-411d-8148-bbc0d60d70af	visitor_1769704930443_phdh2ecrd	2026-01-29 16:42:12.885+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T16:42:12.885Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769704930443_phdh2ecrd", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 16:42:12.646553+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
84f158a2-c9e0-416c-9395-15e2e69412bd	visitor_1769704966931_nkryl850c	2026-01-29 16:42:47.884+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T16:42:47.884Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769704966931_nkryl850c", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 16:42:47.442848+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
94f7de36-5515-4eb4-8773-24cc8d6d4a10	visitor_1769705044783_ermqt3ys2	2026-01-29 16:44:05.59+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T16:44:05.590Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769705044783_ermqt3ys2", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 16:44:05.150897+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
8d66c53c-6b39-48e2-acd0-5e3307577490	visitor_1769705049326_0emso8xds	2026-01-29 16:44:10.099+00	2800:320:4b3a:5d00:3b40:7032:959d:8a1a	192.168.0.17	Telefonica Celular de Bolivia S.A.	AS27882	Bolivia	BO	La Paz Department	La Paz		-16.5	-68.15	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": "AS27882", "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "La Paz", "idioma": "en-US", "region": "La Paz Department", "idiomas": ["en-US"], "latitud": -16.5, "memoria": "8GB", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -68.15, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T16:44:10.099Z", "ip_publica": "2800:320:4b3a:5d00:3b40:7032:959d:8a1a", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769705049326_0emso8xds", "codigo_pais": "BO", "nucleos_cpu": 8, "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 16:44:09.638732+00	\N	\N	\N	\N	\N	\N	\N	\N	\N
d7a5c2a9-18b1-47e2-8f99-9783114a7a22	visitor_1769705953293_e1pv1oolx	2026-01-29 16:59:20.774+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T16:59:20.774Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769705953293_e1pv1oolx", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 16:59:21.592539+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
c13121fc-6dc9-4ce7-a98e-8e1d9042917c	visitor_1769706032210_8lyula0oz	2026-01-29 17:00:40.659+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T17:00:40.659Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769706032210_8lyula0oz", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-01-29 17:00:40.869345+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
191e5090-6248-408b-bf7f-f96c5c5f6da1	visitor_1769706369542_cpj8652h9	2026-01-29 17:06:11.383+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T17:06:11.383Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769706369542_cpj8652h9", "codigo_pais": "BO", "gps_altitud": 431.1000061035156, "gps_latitud": -17.7619483, "nucleos_cpu": 8, "gps_longitud": -63.1524869, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 100, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 17:06:11.156986+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619483	-63.1524869	100	431.10	\N	Obtenido
3b471956-5750-4ece-b567-814430205c9c	visitor_1769706544467_nd68a2cum	2026-01-29 17:09:12.736+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	en-US	{en-US,en,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	vxbo49	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US", "en", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T17:09:12.736Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769706544467_nd68a2cum", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "vxbo49", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-01-29 17:09:12.997152+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
ee68f224-4938-458b-8e4a-e0d5329bfccc	visitor_1769726187989_uzcavjfl1	2026-01-29 22:36:34.208+00	186.121.245.130	172.25.2.139	AXS Bolivia S. A.	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "AXS Bolivia S. A.", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "172.25.2.139", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T22:36:34.208Z", "gps_estado": "Timeout", "ip_publica": "186.121.245.130", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769726187989_uzcavjfl1", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "AXS Bolivia S. A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 22:36:33.906118+00	Andrés Ibáñez Province	\N	AXS Bolivia S. A.	\N	\N	\N	\N	\N	Timeout
52ce6b24-e122-4d14-88a0-47d11fc12bd1	visitor_1769726211225_7dg4k0yvh	2026-01-29 22:36:51.559+00	186.121.245.130	172.25.2.139	AXS Bolivia S. A.	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "AXS Bolivia S. A.", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "172.25.2.139", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T22:36:51.559Z", "gps_estado": "Permiso denegado", "ip_publica": "186.121.245.130", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769726211225_7dg4k0yvh", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "AXS Bolivia S. A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 22:36:51.152679+00	Andrés Ibáñez Province	\N	AXS Bolivia S. A.	\N	\N	\N	\N	\N	Permiso denegado
fe37ce0c-1f4d-486e-b9e9-644d4bbb25cc	visitor_1769726221316_lmqmxjlb9	2026-01-29 22:37:01.735+00	186.121.245.130	172.25.2.139	AXS Bolivia S. A.	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	Directo	{"asn": null, "dnt": "0", "isp": "AXS Bolivia S. A.", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "172.25.2.139", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T22:37:01.735Z", "gps_estado": "Permiso denegado", "ip_publica": "186.121.245.130", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769726221316_lmqmxjlb9", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "AXS Bolivia S. A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 22:37:01.38627+00	Andrés Ibáñez Province	\N	AXS Bolivia S. A.	\N	\N	\N	\N	\N	Permiso denegado
557ec333-64f0-4919-8477-038957f0102b	visitor_1769726246147_bld9pwley	2026-01-29 22:37:31.747+00	186.121.245.130	172.25.2.139	AXS Bolivia S. A.	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	Directo	{"asn": null, "dnt": "0", "isp": "AXS Bolivia S. A.", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "172.25.2.139", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-29T22:37:31.747Z", "gps_estado": "Timeout", "ip_publica": "186.121.245.130", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769726246147_bld9pwley", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "AXS Bolivia S. A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-29 22:37:31.447822+00	Andrés Ibáñez Province	\N	AXS Bolivia S. A.	\N	\N	\N	\N	\N	Timeout
9483a8d8-44f8-43ef-99ed-a87a333e5711	visitor_1769748910662_cj8gqkcjq	2026-01-30 04:55:27.424+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T04:55:27.424Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769748910662_cj8gqkcjq", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 04:55:27.272385+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
b277eb7e-0281-477b-b7a4-b91fa34a2578	visitor_1769749168341_p6g3oatzk	2026-01-30 04:59:43.625+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	5lewmx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T04:59:43.625Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769749168341_p6g3oatzk", "codigo_pais": "BO", "gps_altitud": 431, "gps_latitud": -17.7619171, "nucleos_cpu": 8, "gps_longitud": -63.1524944, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 17, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "5lewmx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 04:59:43.381385+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619171	-63.1524944	17	431.00	\N	Obtenido
b13342e6-cafd-4f48-a0bd-624e2e285a12	visitor_1769749226090_vq2id37yw	2026-01-30 05:00:42.215+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	DMVEVQCEAAYTEDEICAGQL/A8Flf9MkFiUzAAAAAElFTkSuQmCC	Qualcomm	Adreno (TM) 613	5lewmx	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "DMVEVQCEAAYTEDEICAGQL/A8Flf9MkFiUzAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-01-30T05:00:42.215Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769749226090_vq2id37yw", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "5lewmx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:00:41.968187+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
5c108537-1962-421b-912f-de0c2a12e992	visitor_1769749776490_pjh8mntf6	2026-01-30 05:10:05.901+00	189.28.75.192	192.168.0.22	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	360x800	24	8	2GB	es-US	{es-US}	t	0	D//+X985oAAAAGSURBVAMA38oOaf6AJUUAAAAASUVORK5CYII=	Imagination Technologies	PowerVR Rogue GE8322	x9fmjo	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US"], "latitud": -17.79807, "memoria": "2GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.22", "longitud": -63.19251, "canvas_fp": "D//+X985oAAAAGSURBVAMA38oOaf6AJUUAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:10:05.901Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769749776490_pjh8mntf6", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Imagination Technologies", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "PowerVR Rogue GE8322", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "x9fmjo", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "360x800"}	2026-01-30 05:10:08.400314+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
6cf77691-da8e-4c9c-8e2e-17ccb0831558	visitor_1769749974231_qg645ut8r	2026-01-30 05:12:58.953+00	189.28.75.192	192.168.0.22	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv8l	Móvil	t	Mozilla/5.0 (Linux; Android 13; SAMSUNG SM-A032M Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 SamsungBrowser/7.4 Chrome/144.0.7559.59 Mobile Safari/537.36	360x800	24	8	2GB	es-US	{es-US,en-US}	t	0	D//+X985oAAAAGSURBVAMA38oOaf6AJUUAAAAASUVORK5CYII=	Imagination Technologies	PowerVR Rogue GE8322	wk0jmi	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "en-US"], "latitud": -17.79807, "memoria": "2GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.22", "longitud": -63.19251, "canvas_fp": "D//+X985oAAAAGSURBVAMA38oOaf6AJUUAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:12:58.953Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv8l", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 13; SAMSUNG SM-A032M Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 SamsungBrowser/7.4 Chrome/144.0.7559.59 Mobile Safari/537.36", "visitor_id": "visitor_1769749974231_qg645ut8r", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Imagination Technologies", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "PowerVR Rogue GE8322", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "wk0jmi", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "360x800"}	2026-01-30 05:13:01.170673+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
60dc492a-47d8-4ee3-87a2-85ae323beea0	visitor_1769750108939_gcvw90dvg	2026-01-30 05:15:11.637+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:15:11.637Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769750108939_gcvw90dvg", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:15:11.484055+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
10e22396-e900-46de-9c1d-d44e87853f43	visitor_1769750126388_b1mvnm8e7	2026-01-30 05:15:26.968+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:15:26.968Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769750126388_b1mvnm8e7", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:15:26.72658+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
944588a9-0486-4e36-b210-88ba6061c01f	visitor_1769750173169_tz5dt3wjf	2026-01-30 05:16:16.478+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	5lewmx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:16:16.478Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769750173169_tz5dt3wjf", "codigo_pais": "BO", "gps_altitud": 431, "gps_latitud": -17.7619346, "nucleos_cpu": 8, "gps_longitud": -63.1524939, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 14, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "5lewmx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:16:16.152967+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619346	-63.1524939	14	431.00	\N	Obtenido
fb477ba8-863b-4863-bb95-478b98bd828b	visitor_1769750184301_w6xy0tuch	2026-01-30 05:16:28.669+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	5lewmx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:16:28.669Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769750184301_w6xy0tuch", "codigo_pais": "BO", "gps_altitud": 431, "gps_latitud": -17.7619234, "nucleos_cpu": 8, "gps_longitud": -63.1525052, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 14, "gps_velocidad": 0.12776364386081696, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "5lewmx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-01-30 05:16:28.530908+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619234	-63.1525052	14	431.00	0.13	Obtenido
6a084360-8e63-4170-a237-2dc772d358b4	visitor_1769750259214_qigy7os6u	2026-01-30 05:17:48.303+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-01-30T05:17:48.303Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769750259214_qigy7os6u", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-01-30 05:17:48.167138+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
e1591022-bc7d-407b-ae6d-8af51efecca6	visitor_1769972698097_weu3zgeao	2026-02-01 19:05:00.363+00	51.195.235.125	172.16.0.1	OVH Ltd	\N	United Kingdom	GB	England	London	EC4V 4AJ	51.50967	-0.09925	Europe/London	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	kckiyx	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "OVH Ltd", "pais": "United Kingdom", "ciudad": "London", "idioma": "en-US", "region": "England", "idiomas": ["en-US"], "latitud": 51.50967, "memoria": "8GB", "distrito": "Greater London", "es_movil": true, "ip_local": "172.16.0.1", "longitud": -0.09925, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:05:00.363Z", "gps_estado": "Permiso denegado", "ip_publica": "51.195.235.125", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769972698097_weu3zgeao", "codigo_pais": "GB", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "OVH SAS", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "Europe/London", "codigo_postal": "EC4V 4AJ", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "kckiyx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:05:01.082441+00	Greater London	\N	OVH SAS	\N	\N	\N	\N	\N	Permiso denegado
9c4beb33-70ee-49a3-8c42-18598c688341	visitor_1769972738978_y6s1q94y9	2026-02-01 19:05:39.644+00	51.195.235.125	172.16.0.1	OVH Ltd	\N	United Kingdom	GB	England	London	EC4V 4AJ	51.50967	-0.09925	Europe/London	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	kckiyx	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": null, "dnt": "0", "isp": "OVH Ltd", "pais": "United Kingdom", "ciudad": "London", "idioma": "en-US", "region": "England", "idiomas": ["en-US"], "latitud": 51.50967, "memoria": "8GB", "distrito": "Greater London", "es_movil": true, "ip_local": "172.16.0.1", "longitud": -0.09925, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:05:39.644Z", "gps_estado": "Permiso denegado", "ip_publica": "51.195.235.125", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769972738978_y6s1q94y9", "codigo_pais": "GB", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "OVH SAS", "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "Europe/London", "codigo_postal": "EC4V 4AJ", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "kckiyx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:05:39.622756+00	Greater London	\N	OVH SAS	\N	\N	\N	\N	\N	Permiso denegado
8070eade-1924-4ee1-a899-ace34a54d944	visitor_1769972742168_w65n5vnmg	2026-02-01 19:05:42.742+00	51.195.235.125	172.16.0.1	OVH Ltd	\N	United Kingdom	GB	England	London	EC4V 4AJ	51.50967	-0.09925	Europe/London	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	kckiyx	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": null, "dnt": "0", "isp": "OVH Ltd", "pais": "United Kingdom", "ciudad": "London", "idioma": "en-US", "region": "England", "idiomas": ["en-US"], "latitud": 51.50967, "memoria": "8GB", "distrito": "Greater London", "es_movil": true, "ip_local": "172.16.0.1", "longitud": -0.09925, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:05:42.742Z", "gps_estado": "Permiso denegado", "ip_publica": "51.195.235.125", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769972742168_w65n5vnmg", "codigo_pais": "GB", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "OVH SAS", "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "Europe/London", "codigo_postal": "EC4V 4AJ", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "kckiyx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:05:42.738925+00	Greater London	\N	OVH SAS	\N	\N	\N	\N	\N	Permiso denegado
7aef0697-a276-4ee6-b990-a5b79e797537	visitor_1769972986598_pnwji2qw8	2026-02-01 19:09:49.899+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	kckiyx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:09:49.899Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769972986598_pnwji2qw8", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "kckiyx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:09:50.158312+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
acb7afe5-fdce-4f18-aafe-36272cfa0a4d	visitor_1769973109060_xypupz7c6	2026-02-01 19:11:51.131+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	dfy876	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:11:51.131Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769973109060_xypupz7c6", "codigo_pais": "BO", "gps_altitud": 65, "gps_latitud": -37.88907324299617, "nucleos_cpu": 8, "gps_longitud": -65.46991610683435, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 1, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "dfy876", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:11:51.238746+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-37.8890732	-65.4699161	1	65.00	\N	Obtenido
bd71e686-a78e-4800-b295-9b96e1a0340c	visitor_1769973179300_frevrksp8	2026-02-01 19:13:01.137+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US,en,es}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	kckiyx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US", "en", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:13:01.137Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973179300_frevrksp8", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "kckiyx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:13:01.244027+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
bfa39914-07c4-4240-a4fe-980fe3e3b4dd	visitor_1769973270460_2lqfoi964	2026-02-01 19:14:36.187+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux aarch64	Móvil	t	Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn	491x1119	24	8	8GB	es-ES	{es-ES,en-US}	t	0	OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	5lewmx	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES", "en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "OlIigEIICw6AEIQMAMgf8D5ONn06q+eUwAAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:14:36.187Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux aarch64", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 15; Redmi 12 5G Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.50.1-gn", "visitor_id": "visitor_1769973270460_2lqfoi964", "codigo_pais": "BO", "gps_altitud": 431, "gps_latitud": -17.7619354, "nucleos_cpu": 8, "gps_longitud": -63.1525031, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 14, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "5lewmx", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:14:36.164621+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619354	-63.1525031	14	431.00	\N	Obtenido
3d77cf15-6efd-4239-8197-df9661006365	visitor_1769973342031_2ejlbcslz	2026-02-01 19:15:43.81+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US,en,es}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US", "en", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:15:43.810Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973342031_2ejlbcslz", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:15:43.706996+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
d76c917f-7061-4635-ba32-53e713f8bded	visitor_1769973425830_xu0jx14bv	2026-02-01 19:17:08.506+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:17:08.506Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973425830_xu0jx14bv", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:17:08.652556+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
234b217b-d0b7-4dcb-a9af-e1ea0d54ac46	visitor_1769973440376_qjirfpt0m	2026-02-01 19:17:20.82+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:17:20.820Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973440376_qjirfpt0m", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:17:20.681381+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
9c791b95-6b58-48c4-898b-3e6304a9b67a	visitor_1769973447887_g7r85qx53	2026-02-01 19:17:28.372+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:17:28.372Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973447887_g7r85qx53", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:17:28.255938+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
5d1a9b7e-ff8b-4665-9c37-85b8829833c4	visitor_1770028519687_ktr3yi093	2026-02-02 10:35:20.93+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-02T10:35:20.930Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770028519687_ktr3yi093", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-02 10:35:20.951077+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
647552c2-fcd5-4325-bab8-0785cc77e6d7	visitor_1770520658799_nzgumyknp	2026-02-08 03:17:44.753+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T03:17:44.753Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770520658799_nzgumyknp", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 03:17:36.324955+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
e25c752a-69fa-4b95-8b4b-0e5b79e777d5	visitor_1769973526878_fz9bs1sdm	2026-02-01 19:19:07.243+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	6	8GB	es-ES	{es-ES}	t	0	//+9M1fwAAAAZJREFUAwB/yrFqSb/fjQAAAABJRU5ErkJggg==	Qualcomm	Adreno (TM) 613	wdbqs7	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "//+9M1fwAAAAZJREFUAwB/yrFqSb/fjQAAAABJRU5ErkJggg==", "navegador": "Chrome", "timestamp": "2026-02-01T19:19:07.243Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973526878_fz9bs1sdm", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 6, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "wdbqs7", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:19:07.222878+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
73024583-1bc3-4496-8d79-bdc82597864d	visitor_1769973633701_i65yhwm1b	2026-02-01 19:20:50.866+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	5	0.5GB	es-ES	{es-ES}	t	0	AA//86tS2NAAAABklEQVQDAFaOtmqsV4ziAAAAAElFTkSuQmCC	Qualcomm	Adreno (TM) 613	wdbqs6	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES"], "latitud": -17.79807, "memoria": "0.5GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "AA//86tS2NAAAABklEQVQDAFaOtmqsV4ziAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-01T19:20:50.866Z", "gps_estado": "Obtenido", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973633701_i65yhwm1b", "codigo_pais": "BO", "gps_altitud": 431, "gps_latitud": -17.761946, "nucleos_cpu": 5, "gps_longitud": -63.1524821, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": 20, "gps_velocidad": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "wdbqs6", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:20:50.957883+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	-17.7619460	-63.1524821	20	431.00	\N	Obtenido
4ed09cfc-8f94-4390-af4f-f248013aae87	visitor_1769973706358_mknsm3r2t	2026-02-01 19:22:05.43+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	1GB	es-ES	{es-ES}	t	0	//kTLQQgAAAAZJREFUAwBmd8lp18cInwAAAABJRU5ErkJggg==	Qualcomm	Adreno (TM) 613	wdbqs9	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-ES", "region": "Santa Cruz", "idiomas": ["es-ES"], "latitud": -17.79807, "memoria": "1GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "//kTLQQgAAAAZJREFUAwBmd8lp18cInwAAAABJRU5ErkJggg==", "navegador": "Chrome", "timestamp": "2026-02-01T19:22:05.430Z", "gps_estado": "Timeout", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1769973706358_mknsm3r2t", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "wdbqs9", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-01 19:22:05.550909+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Timeout
f9c157d0-6006-46a8-9568-97c4c8c266b9	visitor_1769974677114_6tn8plt1d	2026-02-01 19:38:00.685+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:38:00.685Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769974677114_6tn8plt1d", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-01 19:37:55.602549+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
f421fc27-68e9-4f5e-9d2f-5459a996253a	visitor_1769974701896_aw7lbj2zd	2026-02-01 19:38:24.911+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-01T19:38:24.911Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1769974701896_aw7lbj2zd", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-01 19:38:19.668945+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
3eb81112-16b7-441a-a0f6-cd98ac9d26be	visitor_1769975272724_ksbrlizf2	2026-02-01 19:47:55.909+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/mis-mensajes.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-01T19:47:55.909Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1769975272724_ksbrlizf2", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/mis-mensajes.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-01 19:47:50.683914+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
a6c6e879-0380-45e1-9a8d-7db22b07dd81	visitor_1769975665280_hwgkcpnu1	2026-02-01 19:54:28.421+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-01T19:54:28.421Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1769975665280_hwgkcpnu1", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-01 19:54:23.23391+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
cce6ce26-3566-4179-a411-9577f3d9be18	visitor_1770521614256_48f9ud3yr	2026-02-08 03:33:36.9+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:33:36.900Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770521614256_48f9ud3yr", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:33:28.491009+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
1d62609b-d3cc-42df-929a-54302c1184a5	visitor_1770521647204_oyikrycb3	2026-02-08 03:34:09.506+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:34:09.506Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770521647204_oyikrycb3", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:34:01.000763+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
d5b4f6b4-3ae7-4c3d-b7f9-4fe3ad160fa1	visitor_1770521702252_r1hqw16cp	2026-02-08 03:35:05.379+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:35:05.379Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770521702252_r1hqw16cp", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:34:56.869923+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
a816e9c4-8798-47c9-9c7f-0cb5e3a81436	visitor_1770521710897_jk2mddi6j	2026-02-08 03:35:13.898+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:35:13.898Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770521710897_jk2mddi6j", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:35:05.44813+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
7c347bd0-b6d9-4cf7-ac59-1ffda36356db	visitor_1770521745572_8zegrc3bp	2026-02-08 03:35:48.955+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T03:35:48.955Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770521745572_8zegrc3bp", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 03:35:40.527174+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
8431479e-10db-40d7-bb77-8366963632a8	visitor_1770521991321_46ago8oha	2026-02-08 03:39:54.793+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	en-US	{en-US,en,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	vxbo49	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US", "en", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T03:39:54.793Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770521991321_46ago8oha", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "vxbo49", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 03:39:46.370595+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
e4607ef1-928e-43ab-87ef-7cecd2be0f25	visitor_1770522249835_i4lk072pw	2026-02-08 03:44:12.633+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:44:12.633Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770522249835_i4lk072pw", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:44:04.123306+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
54d04251-c4d6-4fba-9943-2840c575bfd4	visitor_1770522699954_3tc59vaoe	2026-02-08 03:51:43.466+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Safari	macOS	Win32	Móvil	t	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	375x667	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	gigxyg	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Safari", "timestamp": "2026-02-08T03:51:43.466Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1", "visitor_id": "visitor_1770522699954_3tc59vaoe", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "gigxyg", "profundidad_color": 24, "sistema_operativo": "macOS", "cookies_habilitadas": true, "resolucion_pantalla": "375x667"}	2026-02-08 03:51:35.103918+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
b0a9b791-85eb-440f-a4a1-f042d0b6ee34	visitor_1770524693248_0oz6kx7dr	2026-02-08 04:24:53.712+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T04:24:53.712Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770524693248_0oz6kx7dr", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 04:24:54.245835+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
d8f1f120-ab0e-4516-b2cc-69addee0ca05	visitor_1770524884973_gpibtbi3b	2026-02-08 04:28:06.051+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T04:28:06.051Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770524884973_gpibtbi3b", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 04:28:07.023467+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
d2bd774d-aeec-4af8-b0e0-0387cbe9ae29	visitor_1770522867572_r2scsvs9a	2026-02-08 03:54:30.302+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T03:54:30.302Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770522867572_r2scsvs9a", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 03:54:30.911789+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
e0d02b58-e598-4d22-8f85-32cecbdaabb6	visitor_1770522957991_tfyf3f3ad	2026-02-08 03:55:59.001+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T03:55:59.001Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770522957991_tfyf3f3ad", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 03:55:59.555989+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
6921e5ad-09ba-4ffa-88c0-9539613609b6	visitor_1770523742303_7nm0e5l5r	2026-02-08 04:09:03.556+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T04:09:03.556Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770523742303_7nm0e5l5r", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "Directo", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 04:09:04.485173+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
fc98cb97-30c4-4575-8b4d-224d34331b57	visitor_1770524650274_8rc0gspt9	2026-02-08 04:24:12.86+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Linux	Linux armv81	Desktop	f	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	k7dc0x	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T04:24:12.860Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770524650274_8rc0gspt9", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "k7dc0x", "profundidad_color": 24, "sistema_operativo": "Linux", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 04:24:13.580833+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
b2e5a044-7422-4044-80dc-a71a64ae8ab5	visitor_1770524655084_snzq4zile	2026-02-08 04:24:15.571+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T04:24:15.571Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770524655084_snzq4zile", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 04:24:16.114023+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
fb95d084-c023-4eeb-bc3b-0decf925d367	visitor_1770524938743_k4sw78epc	2026-02-08 04:28:59.071+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T04:28:59.071Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770524938743_k4sw78epc", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 04:28:59.92252+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
3a327505-8964-481b-8697-ca1d49ea5ec7	visitor_1770524982826_u56gpagq4	2026-02-08 04:29:44.071+00	189.28.75.192	192.168.0.17	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": true, "ip_local": "192.168.0.17", "longitud": -63.19251, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T04:29:44.071Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770524982826_u56gpagq4", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 04:29:44.61427+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
01bbcf04-36d1-4db5-9014-e2e2b65242ea	visitor_1770525223510_6zzfgt106	2026-02-08 04:33:44.634+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T04:33:44.634Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770525223510_6zzfgt106", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 04:33:45.51538+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
2319a97d-d1b7-434a-8a2a-c84c2c70051c	visitor_1770554997335_5nbtvgbx9	2026-02-08 12:49:58.858+00	192.223.114.72	10.46.242.54	Telefónica Celular de Bolivia S.A.	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79847	-63.17047	America/La_Paz	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	491x1119	24	8	8GB	en-US	{en-US}	t	0	D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=	Qualcomm	Adreno (TM) 613	emumsc	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefónica Celular de Bolivia S.A.", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "en-US", "region": "Santa Cruz", "idiomas": ["en-US"], "latitud": -17.79847, "memoria": "8GB", "distrito": "Andres Ibanez", "es_movil": true, "ip_local": "10.46.242.54", "longitud": -63.17047, "canvas_fp": "D//7R18VYAAAAGSURBVAMAq9vCWt+mIp0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T12:49:58.858Z", "gps_estado": "Permiso denegado", "ip_publica": "192.223.114.72", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770554997335_5nbtvgbx9", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Qualcomm", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Adreno (TM) 613", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "emumsc", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "491x1119"}	2026-02-08 12:49:59.6522+00	Andres Ibanez	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
29f9c412-7af5-4cf7-9fb6-6df58826d47a	visitor_1770581013914_ebb2jizdm	2026-02-08 20:03:39.914+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T20:03:39.914Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770581013914_ebb2jizdm", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 20:03:29.832258+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
975f7135-1086-40bf-b92d-3e1faccb7149	visitor_1770588004905_ijl03uan4	2026-02-08 22:00:07.923+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US,es-419,es}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/Libreta.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US", "es-419", "es"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T22:00:07.923Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770588004905_ijl03uan4", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/Libreta.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 21:59:57.940967+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
f026347b-9598-47ff-b7a5-7f0c2e2bb78c	visitor_1770588030095_gcjsu19xg	2026-02-08 22:00:34.339+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T22:00:34.339Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770588030095_gcjsu19xg", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "Directo", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 22:00:24.319832+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
253a0989-de85-441f-847d-c78cf8c3fdd5	visitor_1770588048925_s7r6ou2t1	2026-02-08 22:00:51.933+00	189.28.75.192	\N	Telefonica Celular de Bolivia S.A	\N	Bolivia	BO	Santa Cruz	Santa Cruz de la Sierra		-17.79807	-63.19251	America/La_Paz	Chrome	Windows 10/11	Win32	Desktop	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	1536x864	24	16	8GB	es-US	{es-US}	t	0	D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=	Google Inc. (Intel)	ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)	8y6w4s	https://leolpa000.github.io/OurCorner/index.html	https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html	{"asn": null, "dnt": "0", "isp": "Telefonica Celular de Bolivia S.A", "pais": "Bolivia", "ciudad": "Santa Cruz de la Sierra", "idioma": "es-US", "region": "Santa Cruz", "idiomas": ["es-US"], "latitud": -17.79807, "memoria": "8GB", "distrito": "Andrés Ibáñez Province", "es_movil": false, "ip_local": null, "longitud": -63.19251, "canvas_fp": "D//0X5rPoAAAAGSURBVAMAzBkOaTPjVl0AAAAASUVORK5CYII=", "navegador": "Chrome", "timestamp": "2026-02-08T22:00:51.933Z", "gps_estado": "Permiso denegado", "ip_publica": "189.28.75.192", "plataforma": "Win32", "url_actual": "https://leolpa000.github.io/OurCorner/index.html", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36", "visitor_id": "visitor_1770588048925_s7r6ou2t1", "codigo_pais": "BO", "gps_latitud": null, "nucleos_cpu": 16, "gps_longitud": null, "organizacion": "Telefónica Celular de Bolivia S.A.", "url_referrer": "https://leolpa000.github.io/OurCorner/views/login.html?return=%2FOurCorner%2Fviews%2Fmis-mensajes.html", "webgl_vendor": "Google Inc. (Intel)", "zona_horaria": "America/La_Paz", "codigo_postal": "", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "ANGLE (Intel, Intel(R) UHD Graphics (0x000046A3) Direct3D11 vs_5_0 ps_5_0, D3D11)", "datos_completos": null, "tipo_dispositivo": "Desktop", "fingerprint_unico": "8y6w4s", "profundidad_color": 24, "sistema_operativo": "Windows 10/11", "cookies_habilitadas": true, "resolucion_pantalla": "1536x864"}	2026-02-08 22:00:41.810031+00	Andrés Ibáñez Province	\N	Telefónica Celular de Bolivia S.A.	\N	\N	\N	\N	\N	Permiso denegado
b1771775-005a-4bc5-9add-1221197a3406	visitor_1770588183838_uwcj5mvu4	2026-02-08 22:03:04.867+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T22:03:04.867Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770588183838_uwcj5mvu4", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "Directo", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 22:03:06.346426+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
5d1bd75e-0ea7-4ba2-8a07-900800f3d3cc	visitor_1770588192219_o3nq80pgm	2026-02-08 22:03:12.533+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T22:03:12.533Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770588192219_o3nq80pgm", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "Directo", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 22:03:13.865726+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
5c7cc10d-c0ca-4347-8ecc-be33f3f2ad51	visitor_1770588210426_whv1gc093	2026-02-08 22:03:31.06+00	181.238.113.149	10.240.218.246	AMX Argentina S.A.	\N	Argentina	AR	Ciudad Autónoma De Buenos Aires	Buenos Aires	C1042	-34.60552	-58.38865	America/Argentina/Buenos_Aires	Chrome	Android	Linux armv81	Móvil	t	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	485x1084	24	8	4GB	es-US	{es-US,es-419,es}	t	0	AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC	ARM	Mali-G57	tqw0ws	https://leolpa000.github.io/OurCorner/	Directo	{"asn": null, "dnt": "0", "isp": "AMX Argentina S.A.", "pais": "Argentina", "ciudad": "Buenos Aires", "idioma": "es-US", "region": "Ciudad Autónoma De Buenos Aires", "idiomas": ["es-US", "es-419", "es"], "latitud": -34.60552, "memoria": "4GB", "distrito": "Comuna 1", "es_movil": true, "ip_local": "10.240.218.246", "longitud": -58.38865, "canvas_fp": "AA///hZHiCAAAABklEQVQDAN/iDWnj82HeAAAAAElFTkSuQmCC", "navegador": "Chrome", "timestamp": "2026-02-08T22:03:31.060Z", "gps_estado": "Permiso denegado", "ip_publica": "181.238.113.149", "plataforma": "Linux armv81", "url_actual": "https://leolpa000.github.io/OurCorner/", "user_agent": "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36", "visitor_id": "visitor_1770588210426_whv1gc093", "codigo_pais": "AR", "gps_latitud": null, "nucleos_cpu": 8, "gps_longitud": null, "organizacion": "Techtel LMDS Comunicaciones Interactivas S.A.", "url_referrer": "Directo", "webgl_vendor": "ARM", "zona_horaria": "America/Argentina/Buenos_Aires", "codigo_postal": "C1042", "conexion_tipo": null, "gps_precision": null, "webgl_renderer": "Mali-G57", "datos_completos": null, "tipo_dispositivo": "Móvil", "fingerprint_unico": "tqw0ws", "profundidad_color": 24, "sistema_operativo": "Android", "cookies_habilitadas": true, "resolucion_pantalla": "485x1084"}	2026-02-08 22:03:32.37562+00	Comuna 1	\N	Techtel LMDS Comunicaciones Interactivas S.A.	\N	\N	\N	\N	\N	Permiso denegado
\.


--
-- TOC entry 4499 (class 0 OID 133921)
-- Dependencies: 388
-- Data for Name: messages_2026_04_24; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_24 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4500 (class 0 OID 133933)
-- Dependencies: 389
-- Data for Name: messages_2026_04_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_25 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4501 (class 0 OID 133945)
-- Dependencies: 390
-- Data for Name: messages_2026_04_26; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_26 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4502 (class 0 OID 133957)
-- Dependencies: 391
-- Data for Name: messages_2026_04_27; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_27 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4503 (class 0 OID 133969)
-- Dependencies: 392
-- Data for Name: messages_2026_04_28; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_28 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4504 (class 0 OID 134067)
-- Dependencies: 393
-- Data for Name: messages_2026_04_29; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_29 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4505 (class 0 OID 134085)
-- Dependencies: 394
-- Data for Name: messages_2026_04_30; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_30 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4479 (class 0 OID 17271)
-- Dependencies: 363
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-11-05 19:44:58
20211116045059	2025-11-05 19:45:02
20211116050929	2025-11-05 19:45:06
20211116051442	2025-11-05 19:45:09
20211116212300	2025-11-05 19:45:13
20211116213355	2025-11-05 19:45:17
20211116213934	2025-11-05 19:45:20
20211116214523	2025-11-05 19:45:24
20211122062447	2025-11-05 19:45:28
20211124070109	2025-11-05 19:45:31
20211202204204	2025-11-05 19:45:34
20211202204605	2025-11-05 19:45:38
20211210212804	2025-11-05 19:45:48
20211228014915	2025-11-05 19:45:51
20220107221237	2025-11-05 19:45:55
20220228202821	2025-11-05 19:45:58
20220312004840	2025-11-05 19:46:01
20220603231003	2025-11-05 19:46:06
20220603232444	2025-11-05 19:46:10
20220615214548	2025-11-05 19:46:13
20220712093339	2025-11-05 19:46:17
20220908172859	2025-11-05 19:46:20
20220916233421	2025-11-05 19:46:23
20230119133233	2025-11-05 19:46:27
20230128025114	2025-11-05 19:46:31
20230128025212	2025-11-05 19:46:35
20230227211149	2025-11-05 19:46:38
20230228184745	2025-11-05 19:46:41
20230308225145	2025-11-05 19:46:44
20230328144023	2025-11-05 19:46:48
20231018144023	2025-11-05 19:46:52
20231204144023	2025-11-05 19:46:57
20231204144024	2025-11-05 19:47:00
20231204144025	2025-11-05 19:47:03
20240108234812	2025-11-05 19:47:07
20240109165339	2025-11-05 19:47:10
20240227174441	2025-11-05 19:47:16
20240311171622	2025-11-05 19:47:20
20240321100241	2025-11-05 19:47:27
20240401105812	2025-11-05 19:47:37
20240418121054	2025-11-05 19:47:41
20240523004032	2025-11-05 19:47:53
20240618124746	2025-11-05 19:47:56
20240801235015	2025-11-05 19:47:59
20240805133720	2025-11-05 19:48:03
20240827160934	2025-11-05 19:48:06
20240919163303	2025-11-05 19:48:10
20240919163305	2025-11-05 19:48:14
20241019105805	2025-11-05 19:48:17
20241030150047	2025-11-05 19:48:29
20241108114728	2025-11-05 19:48:34
20241121104152	2025-11-05 19:48:37
20241130184212	2025-11-05 19:48:41
20241220035512	2025-11-05 19:48:45
20241220123912	2025-11-05 19:48:48
20241224161212	2025-11-05 19:48:51
20250107150512	2025-11-05 19:48:54
20250110162412	2025-11-05 19:48:58
20250123174212	2025-11-05 19:49:01
20250128220012	2025-11-05 19:49:04
20250506224012	2025-11-05 19:49:07
20250523164012	2025-11-05 19:49:10
20250714121412	2025-11-05 19:49:13
20250905041441	2025-11-05 19:49:16
20251103001201	2025-12-20 20:26:59
20251120212548	2026-02-08 03:28:36
20251120215549	2026-02-08 03:28:37
20260218120000	2026-03-02 20:11:59
20260326120000	2026-04-11 22:50:05
\.


--
-- TOC entry 4481 (class 0 OID 17293)
-- Dependencies: 366
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- TOC entry 4459 (class 0 OID 16546)
-- Dependencies: 341
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
archivos	archivos	\N	2025-11-05 21:07:02.390367+00	2025-11-05 21:07:02.390367+00	t	f	52428800	\N	\N	STANDARD
\.


--
-- TOC entry 4478 (class 0 OID 17242)
-- Dependencies: 362
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- TOC entry 4485 (class 0 OID 23159)
-- Dependencies: 373
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4461 (class 0 OID 16588)
-- Dependencies: 343
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-05 19:44:37.506674
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-05 19:44:37.517862
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-05 19:44:37.566468
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-05 19:44:37.668909
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-05 19:44:37.672648
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-05 19:44:37.684124
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-05 19:44:37.686891
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-05 19:44:37.703934
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-05 19:44:37.710558
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-05 19:44:37.71428
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-05 19:44:37.717665
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-05 19:44:37.744332
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-05 19:44:37.748046
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-05 19:44:37.751377
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-05 19:44:37.760139
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-05 19:44:37.765108
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-05 19:44:37.768199
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-05 19:44:37.775412
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-05 19:44:37.79333
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-05 19:44:37.806608
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-05 19:44:37.809852
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-05 19:44:37.813134
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-05 19:44:37.887967
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-17 16:06:41.296209
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-17 16:06:41.358109
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-17 16:06:41.507681
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-17 16:06:41.51207
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2025-12-20 05:10:04.574239
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2025-11-05 19:44:37.524117
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2025-11-05 19:44:37.67988
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2025-11-05 19:44:37.690186
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2025-11-05 19:44:37.694378
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2025-11-05 19:44:37.816472
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2025-11-05 19:44:37.829682
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2025-11-05 19:44:37.841679
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2025-11-05 19:44:37.846686
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2025-11-05 19:44:37.853282
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2025-11-05 19:44:37.859312
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2025-11-05 19:44:37.865282
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2025-11-05 19:44:37.871809
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2025-11-05 19:44:37.873448
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2025-11-05 19:44:37.87951
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2025-11-05 19:44:37.882819
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2025-11-05 19:44:37.89207
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2025-11-05 19:44:37.90037
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2025-11-05 19:44:37.904326
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2025-11-05 19:44:37.911753
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2025-11-05 19:44:37.915461
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2025-11-05 19:44:37.920538
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2025-11-17 16:06:41.514996
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-02-10 16:56:03.168374
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-02-10 16:56:03.252804
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-02-10 16:56:03.254268
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-02-10 16:56:03.371491
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-02-10 16:56:03.373882
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-02-10 16:56:03.375459
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-02-10 16:56:03.383372
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-06 19:02:09.670444
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-06 19:02:09.71082
\.


--
-- TOC entry 4460 (class 0 OID 16561)
-- Dependencies: 342
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
8a4ab90c-c628-4b6a-afd1-e83f30660158	archivos	musica/1762536342292_1_-_Rosa_Linn_-_SNAP.mp3	\N	2025-11-07 17:25:50.024968+00	2025-11-07 17:25:50.024968+00	2025-11-07 17:25:50.024968+00	{"eTag": "\\"57e7770f7954e6b0bf3cd0c31b786392\\"", "size": 3018407, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-07T17:25:50.000Z", "contentLength": 3018407, "httpStatusCode": 200}	d23a775d-9e18-485d-979b-047158be1c41	\N	{}
2214a859-be94-45af-b3b1-952f5982f628	archivos	fotos/1762550673843_1000167507.jpg	\N	2025-11-07 21:24:36.035227+00	2025-11-07 21:24:36.035227+00	2025-11-07 21:24:36.035227+00	{"eTag": "\\"96b6df2f207b77c9afc947ca66207da4\\"", "size": 433417, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-07T21:24:36.000Z", "contentLength": 433417, "httpStatusCode": 200}	758d2a7b-b78e-494d-ad21-17b1e9b56fe2	\N	{}
3cb8b3a0-eea3-475e-abbc-178f851b7004	archivos	fotos/1762551448180_1000167514.png	\N	2025-11-07 21:37:34.651485+00	2025-11-07 21:37:34.651485+00	2025-11-07 21:37:34.651485+00	{"eTag": "\\"39809c4218774236b382269e4d1815fe\\"", "size": 2117619, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-11-07T21:37:35.000Z", "contentLength": 2117619, "httpStatusCode": 200}	5e7ad127-5d89-4e46-965e-8864960c7f57	\N	{}
fd455961-455a-43db-be6d-4240e059464a	archivos	fotos/1763222980746_1000172018.jpg	\N	2025-11-15 16:09:43.160476+00	2025-11-15 16:09:43.160476+00	2025-11-15 16:09:43.160476+00	{"eTag": "\\"a9b04cf10f34d996b39e20f05337ac99\\"", "size": 190612, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-15T16:09:44.000Z", "contentLength": 190612, "httpStatusCode": 200}	1a67744f-3800-4dae-84a6-86c1fadb5dfe	\N	{}
8f2d9886-961a-4b93-8b3a-daba397b4dd9	archivos	fotos/1763937899450_1000172019.jpg	\N	2025-11-23 22:45:00.438304+00	2025-11-23 22:45:00.438304+00	2025-11-23 22:45:00.438304+00	{"eTag": "\\"407eff02448de3698b18cce2d18856c9\\"", "size": 93394, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T22:45:01.000Z", "contentLength": 93394, "httpStatusCode": 200}	102cbd8c-6704-4cde-bf6c-ca8a2995c7a7	\N	{}
e959dbc3-7119-41e8-8b36-f6930be9a707	archivos	fotos/1765340882401_1001467807.png	\N	2025-12-10 04:28:03.586626+00	2025-12-10 04:28:03.586626+00	2025-12-10 04:28:03.586626+00	{"eTag": "\\"8430dc090e0c8b7d24a7199af8a25069\\"", "size": 55332, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-12-10T04:28:04.000Z", "contentLength": 55332, "httpStatusCode": 200}	9dd63925-b69a-449e-93e2-08aa0fdca38b	\N	{}
fdb697ce-88b3-4c65-b277-28d6ffeb35d0	archivos	fotos/1765985135153_1000172021.jpg	\N	2025-12-17 15:25:38.09378+00	2025-12-17 15:25:38.09378+00	2025-12-17 15:25:38.09378+00	{"eTag": "\\"0eb7069f3d3acc75b9cb73f14eb9adea\\"", "size": 59796, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-12-17T15:25:39.000Z", "contentLength": 59796, "httpStatusCode": 200}	7e7a0182-b886-4d0e-ba3a-57679672fff4	\N	{}
a666ee90-1357-4333-908f-ce59a976d920	archivos	musica/1770858030808_A_partir_de_hoy_-_Maite_Perroni_ft._Marco_di_mauro___max_and_maria___M4A_128K_.m4a	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-02-12 01:00:37.235207+00	2026-02-12 01:00:37.235207+00	2026-02-12 01:00:37.235207+00	{"eTag": "\\"5c499c6cc71fb6290c3474524f5015f4\\"", "size": 4062823, "mimetype": "audio/x-m4a", "cacheControl": "max-age=3600", "lastModified": "2026-02-12T01:00:38.000Z", "contentLength": 4062823, "httpStatusCode": 200}	8333daf1-d392-4f1e-947d-3c970fdf3e78	0a4d4080-3cc7-46c0-833b-cc2179b9896c	{}
30840e81-4362-4aaa-9c60-af4acb2cb920	archivos	musica/1770858588183_Contigo_-_R_o_Roma__Fede_Bracamontes___Mar_a_Alexia__Cover_M4A_128K_.m4a	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-02-12 01:09:54.396527+00	2026-02-12 01:09:54.396527+00	2026-02-12 01:09:54.396527+00	{"eTag": "\\"c80c952225896c432b7af7ea4c339bf7\\"", "size": 3746920, "mimetype": "audio/x-m4a", "cacheControl": "max-age=3600", "lastModified": "2026-02-12T01:09:55.000Z", "contentLength": 3746920, "httpStatusCode": 200}	5f0d7813-e89f-4878-a967-f6662a6b15d9	0a4d4080-3cc7-46c0-833b-cc2179b9896c	{}
1ce04174-bcbb-4320-9668-705d4d45a40a	archivos	fotos/1776632159566_1000126700.png	0a4d4080-3cc7-46c0-833b-cc2179b9896c	2026-04-19 20:56:03.256607+00	2026-04-19 20:56:03.256607+00	2026-04-19 20:56:03.256607+00	{"eTag": "\\"cf707719f4f66139444f4313fd8651c1\\"", "size": 1256673, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-04-19T20:56:04.000Z", "contentLength": 1256673, "httpStatusCode": 200}	0f78961e-dbfd-4180-a427-26c188fc7ad8	0a4d4080-3cc7-46c0-833b-cc2179b9896c	{}
\.


--
-- TOC entry 4476 (class 0 OID 17144)
-- Dependencies: 360
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- TOC entry 4477 (class 0 OID 17158)
-- Dependencies: 361
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 4486 (class 0 OID 23169)
-- Dependencies: 374
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3728 (class 0 OID 16658)
-- Dependencies: 344
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 336
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 154, true);


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 377
-- Name: user_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_profiles_id_seq', 10, true);


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 365
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 3995 (class 2606 OID 16829)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3951 (class 2606 OID 16531)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 4123 (class 2606 OID 100138)
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- TOC entry 4125 (class 2606 OID 100136)
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4018 (class 2606 OID 16935)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3973 (class 2606 OID 16953)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3975 (class 2606 OID 16963)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3949 (class 2606 OID 16524)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3997 (class 2606 OID 16822)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3993 (class 2606 OID 16810)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3985 (class 2606 OID 17003)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3987 (class 2606 OID 16797)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 4031 (class 2606 OID 17062)
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- TOC entry 4033 (class 2606 OID 17060)
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- TOC entry 4035 (class 2606 OID 17058)
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- TOC entry 4082 (class 2606 OID 40878)
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4028 (class 2606 OID 17022)
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4039 (class 2606 OID 17084)
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- TOC entry 4041 (class 2606 OID 17086)
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- TOC entry 4022 (class 2606 OID 16988)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3943 (class 2606 OID 16514)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3946 (class 2606 OID 16740)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 4007 (class 2606 OID 16869)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 4009 (class 2606 OID 16867)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4014 (class 2606 OID 16883)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3954 (class 2606 OID 16537)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3980 (class 2606 OID 16761)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4004 (class 2606 OID 16850)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3999 (class 2606 OID 16841)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3936 (class 2606 OID 16923)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3938 (class 2606 OID 16501)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4133 (class 2606 OID 118118)
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 4129 (class 2606 OID 118101)
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 4061 (class 2606 OID 17460)
-- Name: canciones canciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canciones
    ADD CONSTRAINT canciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4114 (class 2606 OID 88903)
-- Name: card_logs card_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_logs
    ADD CONSTRAINT card_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4111 (class 2606 OID 88892)
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- TOC entry 4065 (class 2606 OID 17527)
-- Name: fotos fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_pkey PRIMARY KEY (id);


--
-- TOC entry 4074 (class 2606 OID 17541)
-- Name: mensajes mensajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_pkey PRIMARY KEY (id);


--
-- TOC entry 4087 (class 2606 OID 47516)
-- Name: reacciones reacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT reacciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4118 (class 2606 OID 88914)
-- Name: shared_cards shared_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_cards
    ADD CONSTRAINT shared_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 4092 (class 2606 OID 72914)
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4094 (class 2606 OID 72916)
-- Name: user_profiles user_profiles_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_username_key UNIQUE (username);


--
-- TOC entry 4105 (class 2606 OID 86564)
-- Name: user_roles user_roles_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_email_key UNIQUE (email);


--
-- TOC entry 4107 (class 2606 OID 86560)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4109 (class 2606 OID 86562)
-- Name: user_roles user_roles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_key UNIQUE (user_id);


--
-- TOC entry 4100 (class 2606 OID 76384)
-- Name: visitor_logs visitor_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor_logs
    ADD CONSTRAINT visitor_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4059 (class 2606 OID 17449)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4137 (class 2606 OID 133929)
-- Name: messages_2026_04_24 messages_2026_04_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_24
    ADD CONSTRAINT messages_2026_04_24_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4140 (class 2606 OID 133941)
-- Name: messages_2026_04_25 messages_2026_04_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_25
    ADD CONSTRAINT messages_2026_04_25_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4143 (class 2606 OID 133953)
-- Name: messages_2026_04_26 messages_2026_04_26_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_26
    ADD CONSTRAINT messages_2026_04_26_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4146 (class 2606 OID 133965)
-- Name: messages_2026_04_27 messages_2026_04_27_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_27
    ADD CONSTRAINT messages_2026_04_27_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4149 (class 2606 OID 133977)
-- Name: messages_2026_04_28 messages_2026_04_28_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_28
    ADD CONSTRAINT messages_2026_04_28_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4152 (class 2606 OID 134075)
-- Name: messages_2026_04_29 messages_2026_04_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_29
    ADD CONSTRAINT messages_2026_04_29_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4155 (class 2606 OID 134093)
-- Name: messages_2026_04_30 messages_2026_04_30_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_30
    ADD CONSTRAINT messages_2026_04_30_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4055 (class 2606 OID 17301)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 4052 (class 2606 OID 17275)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4049 (class 2606 OID 23192)
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 3957 (class 2606 OID 16554)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 4076 (class 2606 OID 23168)
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- TOC entry 3965 (class 2606 OID 16595)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3967 (class 2606 OID 16593)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3963 (class 2606 OID 16571)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 4047 (class 2606 OID 17167)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4045 (class 2606 OID 17152)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4079 (class 2606 OID 23178)
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- TOC entry 3952 (class 1259 OID 16532)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3926 (class 1259 OID 16750)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4119 (class 1259 OID 100142)
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- TOC entry 4120 (class 1259 OID 100141)
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- TOC entry 4121 (class 1259 OID 100139)
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- TOC entry 4126 (class 1259 OID 100140)
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- TOC entry 3927 (class 1259 OID 16752)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3928 (class 1259 OID 16753)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3983 (class 1259 OID 16831)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 4016 (class 1259 OID 16939)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3971 (class 1259 OID 16919)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 3971
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3976 (class 1259 OID 16747)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 4019 (class 1259 OID 16936)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 4080 (class 1259 OID 40879)
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- TOC entry 4020 (class 1259 OID 16937)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3991 (class 1259 OID 16942)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3988 (class 1259 OID 16803)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3989 (class 1259 OID 16948)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 4029 (class 1259 OID 17073)
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- TOC entry 4026 (class 1259 OID 17026)
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- TOC entry 4036 (class 1259 OID 17099)
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4037 (class 1259 OID 17097)
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4042 (class 1259 OID 17098)
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- TOC entry 4023 (class 1259 OID 16995)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 4024 (class 1259 OID 16994)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 4025 (class 1259 OID 16996)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3929 (class 1259 OID 16754)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3930 (class 1259 OID 16751)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3939 (class 1259 OID 16515)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3940 (class 1259 OID 16516)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3941 (class 1259 OID 16746)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3944 (class 1259 OID 16833)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3947 (class 1259 OID 16938)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 4010 (class 1259 OID 16875)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 4011 (class 1259 OID 16940)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 4012 (class 1259 OID 16890)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 4015 (class 1259 OID 16889)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3977 (class 1259 OID 16941)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3978 (class 1259 OID 17111)
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- TOC entry 3981 (class 1259 OID 16832)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 4002 (class 1259 OID 16857)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 4005 (class 1259 OID 16856)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 4000 (class 1259 OID 16842)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 4001 (class 1259 OID 17004)
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- TOC entry 3990 (class 1259 OID 17001)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3982 (class 1259 OID 16830)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3931 (class 1259 OID 16910)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 3931
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3932 (class 1259 OID 16748)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3933 (class 1259 OID 16505)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3934 (class 1259 OID 16965)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4131 (class 1259 OID 118125)
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- TOC entry 4134 (class 1259 OID 118124)
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- TOC entry 4127 (class 1259 OID 118107)
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- TOC entry 4130 (class 1259 OID 118108)
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- TOC entry 4062 (class 1259 OID 17549)
-- Name: idx_canciones_creado_en; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_canciones_creado_en ON public.canciones USING btree (creado_en DESC);


--
-- TOC entry 4063 (class 1259 OID 17548)
-- Name: idx_canciones_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_canciones_owner ON public.canciones USING btree (owner);


--
-- TOC entry 4115 (class 1259 OID 88904)
-- Name: idx_card_logs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_logs_created_at ON public.card_logs USING btree (created_at DESC);


--
-- TOC entry 4112 (class 1259 OID 88894)
-- Name: idx_cards_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cards_created_at ON public.cards USING btree (created_at DESC);


--
-- TOC entry 4066 (class 1259 OID 17547)
-- Name: idx_fotos_creado_en; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fotos_creado_en ON public.fotos USING btree (creado_en DESC);


--
-- TOC entry 4067 (class 1259 OID 17546)
-- Name: idx_fotos_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fotos_owner ON public.fotos USING btree (owner);


--
-- TOC entry 4068 (class 1259 OID 17577)
-- Name: idx_mensajes_autor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_autor ON public.mensajes USING btree (autor);


--
-- TOC entry 4069 (class 1259 OID 17587)
-- Name: idx_mensajes_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_categoria ON public.mensajes USING btree (categoria);


--
-- TOC entry 4070 (class 1259 OID 17551)
-- Name: idx_mensajes_creado_en; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_creado_en ON public.mensajes USING btree (creado_en DESC);


--
-- TOC entry 4071 (class 1259 OID 17552)
-- Name: idx_mensajes_referencia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_referencia ON public.mensajes USING btree (referencia_tipo, referencia_id);


--
-- TOC entry 4072 (class 1259 OID 72933)
-- Name: idx_mensajes_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_user_id ON public.mensajes USING btree (user_id);


--
-- TOC entry 4083 (class 1259 OID 47610)
-- Name: idx_reacciones_mensaje_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reacciones_mensaje_id ON public.reacciones USING btree (mensaje_id);


--
-- TOC entry 4084 (class 1259 OID 49446)
-- Name: idx_reacciones_unique_mensaje; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_reacciones_unique_mensaje ON public.reacciones USING btree (mensaje_id);


--
-- TOC entry 4085 (class 1259 OID 72939)
-- Name: idx_reacciones_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reacciones_user_id ON public.reacciones USING btree (user_id);


--
-- TOC entry 4116 (class 1259 OID 88915)
-- Name: idx_shared_cards_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shared_cards_id ON public.shared_cards USING btree (id);


--
-- TOC entry 4088 (class 1259 OID 72924)
-- Name: idx_user_profiles_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_profiles_email ON public.user_profiles USING btree (email);


--
-- TOC entry 4089 (class 1259 OID 72923)
-- Name: idx_user_profiles_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_profiles_user_id ON public.user_profiles USING btree (user_id);


--
-- TOC entry 4090 (class 1259 OID 72922)
-- Name: idx_user_profiles_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_user_profiles_username ON public.user_profiles USING btree (lower((username)::text));


--
-- TOC entry 4101 (class 1259 OID 86576)
-- Name: idx_user_roles_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_roles_email ON public.user_roles USING btree (email);


--
-- TOC entry 4102 (class 1259 OID 86577)
-- Name: idx_user_roles_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_roles_role ON public.user_roles USING btree (role);


--
-- TOC entry 4103 (class 1259 OID 86575)
-- Name: idx_user_roles_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_roles_user_id ON public.user_roles USING btree (user_id);


--
-- TOC entry 4095 (class 1259 OID 76388)
-- Name: idx_visitor_logs_fingerprint; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_visitor_logs_fingerprint ON public.visitor_logs USING btree (fingerprint_unico);


--
-- TOC entry 4096 (class 1259 OID 76386)
-- Name: idx_visitor_logs_ip; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_visitor_logs_ip ON public.visitor_logs USING btree (ip_publica);


--
-- TOC entry 4097 (class 1259 OID 76387)
-- Name: idx_visitor_logs_pais; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_visitor_logs_pais ON public.visitor_logs USING btree (pais);


--
-- TOC entry 4098 (class 1259 OID 76385)
-- Name: idx_visitor_logs_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_visitor_logs_timestamp ON public.visitor_logs USING btree ("timestamp" DESC);


--
-- TOC entry 4053 (class 1259 OID 17450)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 4057 (class 1259 OID 17451)
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4135 (class 1259 OID 133930)
-- Name: messages_2026_04_24_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_24_inserted_at_topic_idx ON realtime.messages_2026_04_24 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4138 (class 1259 OID 133942)
-- Name: messages_2026_04_25_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_25_inserted_at_topic_idx ON realtime.messages_2026_04_25 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4141 (class 1259 OID 133954)
-- Name: messages_2026_04_26_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_26_inserted_at_topic_idx ON realtime.messages_2026_04_26 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4144 (class 1259 OID 133966)
-- Name: messages_2026_04_27_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_27_inserted_at_topic_idx ON realtime.messages_2026_04_27 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4147 (class 1259 OID 133978)
-- Name: messages_2026_04_28_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_28_inserted_at_topic_idx ON realtime.messages_2026_04_28 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4150 (class 1259 OID 134076)
-- Name: messages_2026_04_29_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_29_inserted_at_topic_idx ON realtime.messages_2026_04_29 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4153 (class 1259 OID 134094)
-- Name: messages_2026_04_30_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_30_inserted_at_topic_idx ON realtime.messages_2026_04_30 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4056 (class 1259 OID 86448)
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- TOC entry 3955 (class 1259 OID 16560)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3958 (class 1259 OID 16582)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 4050 (class 1259 OID 23193)
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- TOC entry 4043 (class 1259 OID 17178)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3959 (class 1259 OID 17143)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3960 (class 1259 OID 86646)
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- TOC entry 3961 (class 1259 OID 16583)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4077 (class 1259 OID 23184)
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- TOC entry 4156 (class 0 OID 0)
-- Name: messages_2026_04_24_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_24_inserted_at_topic_idx;


--
-- TOC entry 4157 (class 0 OID 0)
-- Name: messages_2026_04_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_24_pkey;


--
-- TOC entry 4158 (class 0 OID 0)
-- Name: messages_2026_04_25_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_25_inserted_at_topic_idx;


--
-- TOC entry 4159 (class 0 OID 0)
-- Name: messages_2026_04_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_25_pkey;


--
-- TOC entry 4160 (class 0 OID 0)
-- Name: messages_2026_04_26_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_26_inserted_at_topic_idx;


--
-- TOC entry 4161 (class 0 OID 0)
-- Name: messages_2026_04_26_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_26_pkey;


--
-- TOC entry 4162 (class 0 OID 0)
-- Name: messages_2026_04_27_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_27_inserted_at_topic_idx;


--
-- TOC entry 4163 (class 0 OID 0)
-- Name: messages_2026_04_27_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_27_pkey;


--
-- TOC entry 4164 (class 0 OID 0)
-- Name: messages_2026_04_28_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_28_inserted_at_topic_idx;


--
-- TOC entry 4165 (class 0 OID 0)
-- Name: messages_2026_04_28_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_28_pkey;


--
-- TOC entry 4166 (class 0 OID 0)
-- Name: messages_2026_04_29_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_29_inserted_at_topic_idx;


--
-- TOC entry 4167 (class 0 OID 0)
-- Name: messages_2026_04_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_29_pkey;


--
-- TOC entry 4168 (class 0 OID 0)
-- Name: messages_2026_04_30_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_30_inserted_at_topic_idx;


--
-- TOC entry 4169 (class 0 OID 0)
-- Name: messages_2026_04_30_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_30_pkey;


--
-- TOC entry 4199 (class 2620 OID 86579)
-- Name: users on_auth_user_created_role; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created_role AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_role();


--
-- TOC entry 4204 (class 2620 OID 17306)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4200 (class 2620 OID 17234)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 4201 (class 2620 OID 86648)
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- TOC entry 4202 (class 2620 OID 86649)
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- TOC entry 4203 (class 2620 OID 17131)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4172 (class 2606 OID 16734)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4177 (class 2606 OID 16823)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4176 (class 2606 OID 16811)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4175 (class 2606 OID 16798)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4183 (class 2606 OID 17063)
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4184 (class 2606 OID 17068)
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4185 (class 2606 OID 17092)
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4186 (class 2606 OID 17087)
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4182 (class 2606 OID 16989)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4170 (class 2606 OID 16767)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4179 (class 2606 OID 16870)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4180 (class 2606 OID 16943)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4181 (class 2606 OID 16884)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4173 (class 2606 OID 17106)
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4174 (class 2606 OID 16762)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4178 (class 2606 OID 16851)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4198 (class 2606 OID 118119)
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4197 (class 2606 OID 118102)
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4190 (class 2606 OID 72928)
-- Name: mensajes mensajes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4192 (class 2606 OID 47517)
-- Name: reacciones reacciones_mensaje_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT reacciones_mensaje_id_fkey FOREIGN KEY (mensaje_id) REFERENCES public.mensajes(id) ON DELETE CASCADE;


--
-- TOC entry 4193 (class 2606 OID 72934)
-- Name: reacciones reacciones_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT reacciones_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4194 (class 2606 OID 72917)
-- Name: user_profiles user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4195 (class 2606 OID 86570)
-- Name: user_roles user_roles_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id);


--
-- TOC entry 4196 (class 2606 OID 86565)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4171 (class 2606 OID 16572)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4187 (class 2606 OID 17153)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4188 (class 2606 OID 17173)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4189 (class 2606 OID 17168)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4191 (class 2606 OID 23179)
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- TOC entry 4357 (class 0 OID 16525)
-- Dependencies: 339
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4371 (class 0 OID 16929)
-- Dependencies: 355
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4362 (class 0 OID 16727)
-- Dependencies: 346
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4356 (class 0 OID 16518)
-- Dependencies: 338
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4366 (class 0 OID 16816)
-- Dependencies: 350
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4365 (class 0 OID 16804)
-- Dependencies: 349
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4364 (class 0 OID 16791)
-- Dependencies: 348
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4372 (class 0 OID 16979)
-- Dependencies: 356
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4355 (class 0 OID 16507)
-- Dependencies: 337
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4369 (class 0 OID 16858)
-- Dependencies: 353
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4370 (class 0 OID 16876)
-- Dependencies: 354
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4358 (class 0 OID 16533)
-- Dependencies: 340
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4363 (class 0 OID 16757)
-- Dependencies: 347
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4368 (class 0 OID 16843)
-- Dependencies: 352
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4367 (class 0 OID 16834)
-- Dependencies: 351
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4354 (class 0 OID 16495)
-- Dependencies: 335
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4418 (class 3256 OID 74072)
-- Name: user_profiles Actualización solo del propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Actualización solo del propio perfil" ON public.user_profiles FOR UPDATE TO authenticated USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4438 (class 3256 OID 88916)
-- Name: cards Allow public read access to cards; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read access to cards" ON public.cards FOR SELECT USING (true);


--
-- TOC entry 4439 (class 3256 OID 88919)
-- Name: shared_cards Allow public read access to shared_cards; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read access to shared_cards" ON public.shared_cards FOR SELECT USING (true);


--
-- TOC entry 4425 (class 3256 OID 134097)
-- Name: user_roles Autenticados pueden leer user_roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Autenticados pueden leer user_roles" ON public.user_roles FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4390 (class 3256 OID 134048)
-- Name: canciones Canciones - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Canciones - INSERT autenticado" ON public.canciones FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4445 (class 3256 OID 134038)
-- Name: canciones Canciones - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Canciones - SELECT público" ON public.canciones FOR SELECT USING (true);


--
-- TOC entry 4400 (class 3256 OID 134053)
-- Name: card_logs Card logs - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Card logs - INSERT autenticado" ON public.card_logs FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4398 (class 3256 OID 134052)
-- Name: cards Cards - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Cards - INSERT autenticado" ON public.cards FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4447 (class 3256 OID 134041)
-- Name: fotos Fotos - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Fotos - INSERT autenticado" ON public.fotos FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4446 (class 3256 OID 134040)
-- Name: fotos Fotos - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Fotos - SELECT público" ON public.fotos FOR SELECT USING (true);


--
-- TOC entry 4417 (class 3256 OID 74070)
-- Name: user_profiles Lectura pública de perfiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Lectura pública de perfiles" ON public.user_profiles FOR SELECT USING (true);


--
-- TOC entry 4391 (class 3256 OID 134049)
-- Name: mensajes Mensajes - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mensajes - INSERT autenticado" ON public.mensajes FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4444 (class 3256 OID 134036)
-- Name: mensajes Mensajes - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mensajes - SELECT público" ON public.mensajes FOR SELECT USING (true);


--
-- TOC entry 4407 (class 3256 OID 72940)
-- Name: mensajes Mensajes son públicos para lectura; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mensajes son públicos para lectura" ON public.mensajes FOR SELECT USING (true);


--
-- TOC entry 4404 (class 3256 OID 72925)
-- Name: user_profiles Perfiles públicos para lectura; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Perfiles públicos para lectura" ON public.user_profiles FOR SELECT USING (true);


--
-- TOC entry 4415 (class 3256 OID 74067)
-- Name: user_profiles Permitir lectura pública de perfiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Permitir lectura pública de perfiles" ON public.user_profiles FOR SELECT USING (true);


--
-- TOC entry 4424 (class 3256 OID 80907)
-- Name: visitor_logs Permitir lectura pública de visitor_logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Permitir lectura pública de visitor_logs" ON public.visitor_logs FOR SELECT USING (true);


--
-- TOC entry 4423 (class 3256 OID 76390)
-- Name: visitor_logs Permitir leer logs públicamente; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Permitir leer logs públicamente" ON public.visitor_logs FOR SELECT TO anon USING (true);


--
-- TOC entry 4396 (class 3256 OID 134050)
-- Name: reacciones Reacciones - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Reacciones - INSERT autenticado" ON public.reacciones FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4443 (class 3256 OID 134034)
-- Name: reacciones Reacciones - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Reacciones - SELECT público" ON public.reacciones FOR SELECT USING (true);


--
-- TOC entry 4411 (class 3256 OID 72944)
-- Name: reacciones Reacciones son públicas para lectura; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Reacciones son públicas para lectura" ON public.reacciones FOR SELECT USING (true);


--
-- TOC entry 4401 (class 3256 OID 134054)
-- Name: shared_cards Shared cards - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Shared cards - INSERT autenticado" ON public.shared_cards FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4405 (class 3256 OID 72926)
-- Name: user_profiles Sistema puede crear perfiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Sistema puede crear perfiles" ON public.user_profiles FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4431 (class 3256 OID 86602)
-- Name: canciones Solo admins pueden actualizar canciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden actualizar canciones" ON public.canciones FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4435 (class 3256 OID 86606)
-- Name: fotos Solo admins pueden actualizar fotos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden actualizar fotos" ON public.fotos FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4427 (class 3256 OID 86598)
-- Name: mensajes Solo admins pueden actualizar mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden actualizar mensajes" ON public.mensajes FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4432 (class 3256 OID 86603)
-- Name: canciones Solo admins pueden eliminar canciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden eliminar canciones" ON public.canciones FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4436 (class 3256 OID 86607)
-- Name: fotos Solo admins pueden eliminar fotos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden eliminar fotos" ON public.fotos FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4428 (class 3256 OID 86599)
-- Name: mensajes Solo admins pueden eliminar mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden eliminar mensajes" ON public.mensajes FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4430 (class 3256 OID 86601)
-- Name: canciones Solo admins pueden insertar canciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden insertar canciones" ON public.canciones FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4434 (class 3256 OID 86605)
-- Name: fotos Solo admins pueden insertar fotos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden insertar fotos" ON public.fotos FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4426 (class 3256 OID 86597)
-- Name: mensajes Solo admins pueden insertar mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden insertar mensajes" ON public.mensajes FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role = ANY (ARRAY['super_admin'::text, 'admin'::text]))))));


--
-- TOC entry 4441 (class 3256 OID 134099)
-- Name: user_roles Super admin puede actualizar roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admin puede actualizar roles" ON public.user_roles FOR UPDATE USING ((( SELECT user_roles_1.role
   FROM public.user_roles user_roles_1
  WHERE (user_roles_1.user_id = auth.uid())
 LIMIT 1) = 'super_admin'::text)) WITH CHECK ((( SELECT user_roles_1.role
   FROM public.user_roles user_roles_1
  WHERE (user_roles_1.user_id = auth.uid())
 LIMIT 1) = 'super_admin'::text));


--
-- TOC entry 4440 (class 3256 OID 134098)
-- Name: user_roles Super admin puede crear roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admin puede crear roles" ON public.user_roles FOR INSERT WITH CHECK ((( SELECT user_roles_1.role
   FROM public.user_roles user_roles_1
  WHERE (user_roles_1.user_id = auth.uid())
 LIMIT 1) = 'super_admin'::text));


--
-- TOC entry 4442 (class 3256 OID 134101)
-- Name: user_roles Super admin puede eliminar roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admin puede eliminar roles" ON public.user_roles FOR DELETE USING ((( SELECT user_roles_1.role
   FROM public.user_roles user_roles_1
  WHERE (user_roles_1.user_id = auth.uid())
 LIMIT 1) = 'super_admin'::text));


--
-- TOC entry 4433 (class 3256 OID 86604)
-- Name: canciones Todos pueden leer canciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Todos pueden leer canciones" ON public.canciones FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4437 (class 3256 OID 86608)
-- Name: fotos Todos pueden leer fotos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Todos pueden leer fotos" ON public.fotos FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4429 (class 3256 OID 86600)
-- Name: mensajes Todos pueden leer mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Todos pueden leer mensajes" ON public.mensajes FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4397 (class 3256 OID 134051)
-- Name: user_profiles User profiles - INSERT autenticado; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "User profiles - INSERT autenticado" ON public.user_profiles FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4448 (class 3256 OID 134042)
-- Name: user_profiles User profiles - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "User profiles - SELECT público" ON public.user_profiles FOR SELECT USING (true);


--
-- TOC entry 4416 (class 3256 OID 74069)
-- Name: user_profiles Usuario puede actualizar su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuario puede actualizar su propio perfil" ON public.user_profiles FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4408 (class 3256 OID 72941)
-- Name: mensajes Usuarios autenticados pueden crear mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios autenticados pueden crear mensajes" ON public.mensajes FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4412 (class 3256 OID 72945)
-- Name: reacciones Usuarios autenticados pueden crear reacciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios autenticados pueden crear reacciones" ON public.reacciones FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4406 (class 3256 OID 72927)
-- Name: user_profiles Usuarios pueden actualizar su perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden actualizar su perfil" ON public.user_profiles FOR UPDATE TO authenticated USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4413 (class 3256 OID 72946)
-- Name: reacciones Usuarios pueden actualizar sus propias reacciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden actualizar sus propias reacciones" ON public.reacciones FOR UPDATE TO authenticated USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4409 (class 3256 OID 72942)
-- Name: mensajes Usuarios pueden actualizar sus propios mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden actualizar sus propios mensajes" ON public.mensajes FOR UPDATE TO authenticated USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4414 (class 3256 OID 72947)
-- Name: reacciones Usuarios pueden eliminar sus propias reacciones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden eliminar sus propias reacciones" ON public.reacciones FOR DELETE TO authenticated USING ((auth.uid() = user_id));


--
-- TOC entry 4410 (class 3256 OID 72943)
-- Name: mensajes Usuarios pueden eliminar sus propios mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden eliminar sus propios mensajes" ON public.mensajes FOR DELETE TO authenticated USING ((auth.uid() = user_id));


--
-- TOC entry 4422 (class 3256 OID 134057)
-- Name: visitor_logs Visitor logs - INSERT pÃºblico; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Visitor logs - INSERT pÃºblico" ON public.visitor_logs FOR INSERT WITH CHECK (true);


--
-- TOC entry 4449 (class 3256 OID 134044)
-- Name: visitor_logs Visitor logs - SELECT público; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Visitor logs - SELECT público" ON public.visitor_logs FOR SELECT USING (true);


--
-- TOC entry 4403 (class 3256 OID 47718)
-- Name: reacciones allow_select_public; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY allow_select_public ON public.reacciones FOR SELECT USING (true);


--
-- TOC entry 4377 (class 0 OID 17452)
-- Dependencies: 370
-- Name: canciones; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.canciones ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4395 (class 3256 OID 17513)
-- Name: canciones canciones_select_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY canciones_select_all ON public.canciones FOR SELECT USING (true);


--
-- TOC entry 4387 (class 0 OID 88895)
-- Dependencies: 383
-- Name: card_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.card_logs ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4386 (class 0 OID 88884)
-- Dependencies: 382
-- Name: cards; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4378 (class 0 OID 17517)
-- Dependencies: 371
-- Name: fotos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.fotos ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4399 (class 3256 OID 17528)
-- Name: fotos fotos_select_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY fotos_select_all ON public.fotos FOR SELECT USING (true);


--
-- TOC entry 4379 (class 0 OID 17532)
-- Dependencies: 372
-- Name: mensajes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.mensajes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4402 (class 3256 OID 17542)
-- Name: mensajes mensajes_select_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY mensajes_select_all ON public.mensajes FOR SELECT USING (true);


--
-- TOC entry 4389 (class 3256 OID 17461)
-- Name: canciones public_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_select ON public.canciones FOR SELECT USING (true);


--
-- TOC entry 4382 (class 0 OID 47508)
-- Dependencies: 376
-- Name: reacciones; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reacciones ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4388 (class 0 OID 88905)
-- Dependencies: 384
-- Name: shared_cards; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.shared_cards ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4383 (class 0 OID 72907)
-- Dependencies: 378
-- Name: user_profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4385 (class 0 OID 86549)
-- Dependencies: 381
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4384 (class 0 OID 76374)
-- Dependencies: 379
-- Name: visitor_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.visitor_logs ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4376 (class 0 OID 17435)
-- Dependencies: 369
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4420 (class 3256 OID 74121)
-- Name: objects Usuarios autenticados pueden actualizar archivos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Usuarios autenticados pueden actualizar archivos" ON storage.objects FOR UPDATE TO authenticated USING ((bucket_id = 'archivos'::text)) WITH CHECK ((bucket_id = 'archivos'::text));


--
-- TOC entry 4421 (class 3256 OID 74122)
-- Name: objects Usuarios autenticados pueden eliminar archivos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Usuarios autenticados pueden eliminar archivos" ON storage.objects FOR DELETE TO authenticated USING ((bucket_id = 'archivos'::text));


--
-- TOC entry 4419 (class 3256 OID 74120)
-- Name: objects Usuarios autenticados pueden subir archivos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Usuarios autenticados pueden subir archivos" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'archivos'::text));


--
-- TOC entry 4393 (class 3256 OID 17510)
-- Name: objects allow_anon_delete_archivos 16n9mhz_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow_anon_delete_archivos 16n9mhz_0" ON storage.objects FOR DELETE TO anon USING ((bucket_id = 'archivos'::text));


--
-- TOC entry 4394 (class 3256 OID 17511)
-- Name: objects allow_anon_update_archivos 16n9mhz_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow_anon_update_archivos 16n9mhz_0" ON storage.objects FOR UPDATE TO anon USING ((bucket_id = 'archivos'::text));


--
-- TOC entry 4392 (class 3256 OID 17508)
-- Name: objects allow_anon_upload_archivos 16n9mhz_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "allow_anon_upload_archivos 16n9mhz_0" ON storage.objects FOR INSERT TO anon WITH CHECK ((bucket_id = 'archivos'::text));


--
-- TOC entry 4359 (class 0 OID 16546)
-- Dependencies: 341
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4375 (class 0 OID 17242)
-- Dependencies: 362
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4380 (class 0 OID 23159)
-- Dependencies: 373
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4361 (class 0 OID 16588)
-- Dependencies: 343
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4360 (class 0 OID 16561)
-- Dependencies: 342
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4373 (class 0 OID 17144)
-- Dependencies: 360
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4374 (class 0 OID 17158)
-- Dependencies: 361
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4381 (class 0 OID 23169)
-- Dependencies: 374
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4450 (class 6104 OID 16426)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4451 (class 6104 OID 47694)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- TOC entry 4452 (class 6106 OID 47695)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 25
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 27
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 26
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 471
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 490
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 496
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4578 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4579 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION get_all_users_with_roles(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_all_users_with_roles() TO anon;
GRANT ALL ON FUNCTION public.get_all_users_with_roles() TO authenticated;
GRANT ALL ON FUNCTION public.get_all_users_with_roles() TO service_role;


--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION get_user_role(user_id_param uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_user_role(user_id_param uuid) TO anon;
GRANT ALL ON FUNCTION public.get_user_role(user_id_param uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_user_role(user_id_param uuid) TO service_role;


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION handle_new_user_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user_role() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user_role() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user_role() TO service_role;


--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 492
-- Name: FUNCTION reacciones_conteo(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.reacciones_conteo() TO anon;
GRANT ALL ON FUNCTION public.reacciones_conteo() TO authenticated;
GRANT ALL ON FUNCTION public.reacciones_conteo() TO service_role;


--
-- TOC entry 4593 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION reacciones_conteo(mensaje uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.reacciones_conteo(mensaje uuid) TO anon;
GRANT ALL ON FUNCTION public.reacciones_conteo(mensaje uuid) TO authenticated;
GRANT ALL ON FUNCTION public.reacciones_conteo(mensaje uuid) TO service_role;


--
-- TOC entry 4594 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION user_has_role(required_role text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.user_has_role(required_role text) TO anon;
GRANT ALL ON FUNCTION public.user_has_role(required_role text) TO authenticated;
GRANT ALL ON FUNCTION public.user_has_role(required_role text) TO service_role;


--
-- TOC entry 4595 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4596 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4597 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4598 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4599 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4600 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4601 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- TOC entry 4602 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4611 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4612 (class 0 OID 0)
-- Dependencies: 385
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- TOC entry 4614 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 375
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 336
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE canciones; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.canciones TO anon;
GRANT ALL ON TABLE public.canciones TO authenticated;
GRANT ALL ON TABLE public.canciones TO service_role;


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE card_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.card_logs TO anon;
GRANT ALL ON TABLE public.card_logs TO authenticated;
GRANT ALL ON TABLE public.card_logs TO service_role;


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE cards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cards TO anon;
GRANT ALL ON TABLE public.cards TO authenticated;
GRANT ALL ON TABLE public.cards TO service_role;


--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 371
-- Name: TABLE fotos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.fotos TO anon;
GRANT ALL ON TABLE public.fotos TO authenticated;
GRANT ALL ON TABLE public.fotos TO service_role;


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE mensajes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mensajes TO anon;
GRANT ALL ON TABLE public.mensajes TO authenticated;
GRANT ALL ON TABLE public.mensajes TO service_role;


--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE reacciones; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reacciones TO anon;
GRANT ALL ON TABLE public.reacciones TO authenticated;
GRANT ALL ON TABLE public.reacciones TO service_role;


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE shared_cards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.shared_cards TO anon;
GRANT ALL ON TABLE public.shared_cards TO authenticated;
GRANT ALL ON TABLE public.shared_cards TO service_role;


--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE user_profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_profiles TO anon;
GRANT ALL ON TABLE public.user_profiles TO authenticated;
GRANT ALL ON TABLE public.user_profiles TO service_role;


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 377
-- Name: SEQUENCE user_profiles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_profiles_id_seq TO anon;
GRANT ALL ON SEQUENCE public.user_profiles_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.user_profiles_id_seq TO service_role;


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 381
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO anon;
GRANT ALL ON TABLE public.user_roles TO authenticated;
GRANT ALL ON TABLE public.user_roles TO service_role;


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE visitor_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.visitor_logs TO anon;
GRANT ALL ON TABLE public.visitor_logs TO authenticated;
GRANT ALL ON TABLE public.visitor_logs TO service_role;


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 380
-- Name: TABLE visitor_stats; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.visitor_stats TO anon;
GRANT ALL ON TABLE public.visitor_stats TO authenticated;
GRANT ALL ON TABLE public.visitor_stats TO service_role;


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE messages_2026_04_24; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_24 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_24 TO dashboard_user;


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE messages_2026_04_25; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_25 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_25 TO dashboard_user;


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE messages_2026_04_26; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_26 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_26 TO dashboard_user;


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 391
-- Name: TABLE messages_2026_04_27; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_27 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_27 TO dashboard_user;


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE messages_2026_04_28; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_28 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_28 TO dashboard_user;


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 393
-- Name: TABLE messages_2026_04_29; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_29 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_29 TO dashboard_user;


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE messages_2026_04_30; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_30 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_30 TO dashboard_user;


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 365
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2542 (class 826 OID 16603)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2543 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2541 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2552 (class 826 OID 16682)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2551 (class 826 OID 16681)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2550 (class 826 OID 16680)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2555 (class 826 OID 16637)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2554 (class 826 OID 16636)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2553 (class 826 OID 16635)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2547 (class 826 OID 16617)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2549 (class 826 OID 16616)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2548 (class 826 OID 16615)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2534 (class 826 OID 16490)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2535 (class 826 OID 16491)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2533 (class 826 OID 16489)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2537 (class 826 OID 16493)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2532 (class 826 OID 16488)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2536 (class 826 OID 16492)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2545 (class 826 OID 16607)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2546 (class 826 OID 16608)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2544 (class 826 OID 16606)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2540 (class 826 OID 16545)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2539 (class 826 OID 16544)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2538 (class 826 OID 16543)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3723 (class 3466 OID 16621)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3726 (class 3466 OID 16700)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3722 (class 3466 OID 16619)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3727 (class 3466 OID 16703)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 3724 (class 3466 OID 16622)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3725 (class 3466 OID 16623)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2026-04-26 22:46:19

--
-- PostgreSQL database dump complete
--

\unrestrict UDNCnKqlxUfJarcaeQEkk1ej1cJgTmAqBOXpNYdK2qb8wvi6w3kSI7p3HoghdHU

