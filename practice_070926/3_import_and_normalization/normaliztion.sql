-- empty data to NULL
UPDATE partners SET
    company_name = NULLIF(TRIM(company_name), ''),
    inn = NULLIF(TRIM(inn), ''),
    email = NULLIF(TRIM(email), ''),
    phone = NULLIF(TRIM(phone), ''),
    rating = CASE 
        WHEN TRIM(rating::TEXT) = '' THEN NULL 
        ELSE rating 
    END;