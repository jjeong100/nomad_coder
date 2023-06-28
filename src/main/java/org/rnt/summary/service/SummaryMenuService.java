package org.rnt.summary.service;

import org.rnt.com.vo.RtnVO;
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

public interface SummaryMenuService {
    //-------------------------------------------------------------------------
    // 설비실적 : equipSumList
    //-------------------------------------------------------------------------
    public RtnVO searchEquipSumList(EquipSumInVO param);
    public RtnVO searchEquipSumListTotCnt(EquipSumInVO param);
    
    public RtnVO searchEquipMonthSumList(EquipSumInVO param);
    public RtnVO searchEquipMonthSumListTotCnt(EquipSumInVO param);
    
    public RtnVO searchWorkerSumList(WorkerSumInVO param);
    public RtnVO searchWorkerSumListTotCnt(WorkerSumInVO param);
    
    public RtnVO searchProductionSumList(ProductionSumVO param);
    public RtnVO searchProductionSumListTotCnt(ProductionSumVO param);
    
    public RtnVO searchMonthSumList(WorkerMonthSumVO param);
    public RtnVO searchMonthSumListTotCnt(WorkerMonthSumVO param);
    
    public RtnVO searchLotTrackingItemList(LotTrackingVO param);
    public RtnVO searchLotTrackingMatList(LotTrackingVO param);
    public RtnVO searchLotTrackingWorkSumList(LotTrackingVO param);
    public RtnVO searchLotTrackingItemOutList(LotTrackingVO param);
    
    public RtnVO searchSafetyStockList(SafetyStockVO param);
    public RtnVO searchSafetyStockListTotCnt(SafetyStockVO param);
    
    public RtnVO searchWorkOrderBySumList(WorkOrderBySumVO param);
    public RtnVO searchWorkOrderBySumListTotCnt(WorkOrderBySumVO param);
    
    public RtnVO searchOperSumList(OperSumVO param);
    public RtnVO searchOperSumListTotCnt(OperSumVO param);
    public RtnVO searchItemSumList(ItemSumVO param);
    public RtnVO searchItemSumListTotCnt(ItemSumVO param);
    public RtnVO searchFailureSumList(FailureSumVO param);
    public RtnVO searchFailureSumListTotCnt(FailureSumVO param);
    public RtnVO searchAssignSumList(AssignSumVO param);
    public RtnVO searchAssignSumListTotCnt(AssignSumVO param);
}
