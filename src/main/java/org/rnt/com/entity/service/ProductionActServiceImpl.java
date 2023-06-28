package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ProductionActDao;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("productionActService")
public class ProductionActServiceImpl extends BaseService implements ProductionActService{

    @Resource(name="productionActDao")
    private ProductionActDao productionActDao;
    
    @Override
    public RtnVO getSeq() {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.getSeq();
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO insert(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO select(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.select(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectByProdAndOper(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.selectByProdAndOper(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectByProd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.selectByProd(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO update(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO delete(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.delete(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchList(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.searchList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchListTotCnt(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.searchListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updatePlcProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.updatePlcProdSeq(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectIngProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.selectIngProdSeq(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updateProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.updateProdTypeCd(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchWorkEquiplist(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.searchWorkEquiplist(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO deleteWat(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.deleteWat(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updateRevertProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.updateRevertProdTypeCd(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updateEndProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.updateEndProdTypeCd(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectPreSumQty(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.selectPreSumQty(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO updatePlcEquipByProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionActDao.updatePlcEquipByProdSeq(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
