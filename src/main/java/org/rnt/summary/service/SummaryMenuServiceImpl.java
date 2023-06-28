package org.rnt.summary.service;

import javax.annotation.Resource;

import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.summary.dao.SummaryMenuDao;
import org.rnt.summary.vo.AssignSumVO;
import org.rnt.summary.vo.EquipSumInVO;
import org.rnt.summary.vo.FailureSumVO;
import org.rnt.summary.vo.ItemSumVO;
import org.rnt.summary.vo.LotTrackingVO;
import org.rnt.summary.vo.OperSumVO;
import org.rnt.summary.vo.ProductionSumVO;
import org.rnt.summary.vo.SafetyStockVO;
import org.rnt.summary.vo.WorkOrderBySumVO;
import org.rnt.summary.vo.WorkerMonthSumVO;
import org.rnt.summary.vo.WorkerSumInVO;
import org.springframework.stereotype.Service;

@Service("summaryMenuService")
public class SummaryMenuServiceImpl extends BaseService implements SummaryMenuService {

    @Resource(name="summaryMenuDao")
    private SummaryMenuDao summaryMenuDao;

    @Override
    public RtnVO searchEquipSumList(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchEquipSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchEquipSumListTotCnt(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchEquipSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchEquipMonthSumList(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchEquipMonthSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchEquipMonthSumListTotCnt(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchEquipMonthSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchWorkerSumList(WorkerSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchWorkerSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchWorkerSumListTotCnt(WorkerSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchWorkerSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchProductionSumList(ProductionSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchProductionSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchProductionSumListTotCnt(ProductionSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchProductionSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchMonthSumList(WorkerMonthSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchMonthSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchMonthSumListTotCnt(WorkerMonthSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchMonthSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchLotTrackingItemList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchLotTrackingItemList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchLotTrackingMatList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchLotTrackingMatList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchLotTrackingWorkSumList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchLotTrackingWorkSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchLotTrackingItemOutList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchLotTrackingItemOutList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    @Override
    public RtnVO searchSafetyStockList(SafetyStockVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchSafetyStockList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    @Override
    public RtnVO searchSafetyStockListTotCnt(SafetyStockVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchSafetyStockListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchWorkOrderBySumList(WorkOrderBySumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchWorkOrderBySumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchWorkOrderBySumListTotCnt(WorkOrderBySumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchWorkOrderBySumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchOperSumList(OperSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchOperSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchOperSumListTotCnt(OperSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchOperSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchItemSumList(ItemSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchItemSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchItemSumListTotCnt(ItemSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchItemSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchFailureSumList(FailureSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchFailureSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchFailureSumListTotCnt(FailureSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchFailureSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchAssignSumList(AssignSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchAssignSumList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchAssignSumListTotCnt(AssignSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = summaryMenuDao.searchAssignSumListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

}
