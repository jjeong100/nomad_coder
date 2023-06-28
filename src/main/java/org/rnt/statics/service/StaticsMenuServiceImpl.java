package org.rnt.statics.service;

import javax.annotation.Resource;

import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.statics.dao.StaticsMenuDao;
import org.rnt.statics.vo.DeliveryStaticsInVO;
import org.rnt.statics.vo.EquipStaticsInVO;
import org.rnt.statics.vo.QualityStaticsInVO;
import org.springframework.stereotype.Service;

@Service("staticsMenuService")
public class StaticsMenuServiceImpl extends BaseService implements StaticsMenuService {

    @Resource(name="staticsMenuDao")
    private StaticsMenuDao staticsMenuDao;

    @Override
    public RtnVO searchEquipStaticsList(EquipStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.searchEquipStaticsList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectEquipTotStatics(EquipStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.selectEquipTotStatics(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchQualityStaticsList(QualityStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.searchQualityStaticsList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchDeliveryStaticsList(DeliveryStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.searchDeliveryStaticsList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectQualityTotStatics(QualityStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.selectQualityTotStatics(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    
    @Override
    public RtnVO searchEquipStaticsListTotCnt(EquipStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.searchEquipStaticsListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectDeliveryTotStatics(DeliveryStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = staticsMenuDao.selectDeliveryTotStatics(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
}
