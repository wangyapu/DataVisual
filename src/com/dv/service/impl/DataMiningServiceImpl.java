package com.dv.service.impl;

import com.dv.dao.DataSourceDAO;
import com.dv.service.DataMiningService;


public class DataMiningServiceImpl implements DataMiningService {
    DataSourceDAO dsDAO;

    public DataSourceDAO getDsDAO() {
        return dsDAO;
    }

    public void setDsDAO(DataSourceDAO dsDAO) {
        this.dsDAO = dsDAO;
    }

}
