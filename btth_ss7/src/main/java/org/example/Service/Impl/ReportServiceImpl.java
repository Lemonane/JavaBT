package org.example.Service.Impl;

import org.example.Dao.ReportDao;
import org.example.Service.ReportService;

import java.sql.SQLException;

public class ReportServiceImpl implements ReportService {
    private final ReportDao reportDao;

    public ReportServiceImpl(ReportDao reportDao) {
        this.reportDao = reportDao;
    }

    @Override
    public void reportNumberOfCategoriesByCategoryStatus() {
        try {
            reportDao.reportNumberOfCategoriesByCategoryStatus();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void reportNumberOfProductsByProductStatus() {
        try {
            reportDao.reportNumberOfProductsByProductStatus();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void reportNumberOfProductsByEachCategory() {
        try {
            reportDao.reportNumberOfProductsByEachCategory();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
