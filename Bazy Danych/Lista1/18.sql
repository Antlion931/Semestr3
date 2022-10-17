ALTER TABLE language ADD COLUMN IF NOT EXISTS films_no int;

UPDATE language AS l SET films_no = (SELECT count(*) FROM film WHERE language_id = l.language_id);