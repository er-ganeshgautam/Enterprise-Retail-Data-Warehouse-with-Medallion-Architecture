CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
BEGIN
    batch_start_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '------------------------------------------------';

    -- crm_cust_info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
    EXECUTE 'TRUNCATE TABLE bronze.crm_cust_info';
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
    EXECUTE format(
        'COPY bronze.crm_cust_info FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_crm/cust_info.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- crm_prd_info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
    EXECUTE 'TRUNCATE TABLE bronze.crm_prd_info';
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
    EXECUTE format(
        'COPY bronze.crm_prd_info FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_crm/prd_info.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- crm_sales_details
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
    EXECUTE 'TRUNCATE TABLE bronze.crm_sales_details';
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
    EXECUTE format(
        'COPY bronze.crm_sales_details FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_crm/sales_details.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '------------------------------------------------';

    -- erp_loc_a101
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
    EXECUTE 'TRUNCATE TABLE bronze.erp_loc_a101';
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
    EXECUTE format(
        'COPY bronze.erp_loc_a101 FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- erp_cust_az12
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
    EXECUTE 'TRUNCATE TABLE bronze.erp_cust_az12';
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
    EXECUTE format(
        'COPY bronze.erp_cust_az12 FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- erp_px_cat_g1v2
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
    EXECUTE 'TRUNCATE TABLE bronze.erp_px_cat_g1v2';
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
    EXECUTE format(
        'COPY bronze.erp_px_cat_g1v2 FROM %L CSV HEADER',
        'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv'
    );
    end_time := clock_timestamp();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    batch_end_time := clock_timestamp();

    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Loading Bronze Layer is Completed';
    RAISE NOTICE '   - Total Load Duration: % seconds', EXTRACT(EPOCH FROM batch_end_time - batch_start_time);
    RAISE NOTICE '==========================================';

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
    RAISE NOTICE 'Error Message: %', SQLERRM;
    RAISE NOTICE '==========================================';
END;
$$;

