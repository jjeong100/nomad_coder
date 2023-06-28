package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.MaterialAdjustmentDao;
import org.rnt.com.entity.vo.MaterialAdjustmentVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialAdjustmentService")
public class MaterialAdjustmentServiceImpl extends BaseService implements MaterialAdjustmentService{

    @Resource(name="materialAdjustmentDao")
    private MaterialAdjustmentDao materialAdjustmentDao;

    @Override
    public RtnVO insert(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO select(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.select(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO update(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO delete(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.delete(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchList(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.searchList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchListTotCnt(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.searchListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updateMaterialIn(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.updateMaterialIn(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updateMaterialOut(MaterialAdjustmentVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialAdjustmentDao.updateMaterialOut(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
