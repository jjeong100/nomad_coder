package org.rnt.statics.service;

import org.rnt.com.vo.RtnVO;
import org.rnt.statics.vo.DeliveryStaticsInVO;
import org.rnt.statics.vo.EquipStaticsInVO;
import org.rnt.statics.vo.QualityStaticsInVO;

public interface StaticsMenuService {
    //-------------------------------------------------------------------------
    // 설비실적 : searchEquipStaticsList
    //-------------------------------------------------------------------------
    public RtnVO searchEquipStaticsList(EquipStaticsInVO param);
    public RtnVO selectEquipTotStatics(EquipStaticsInVO param);
    public RtnVO searchQualityStaticsList(QualityStaticsInVO param);
    public RtnVO searchDeliveryStaticsList(DeliveryStaticsInVO param);
    public RtnVO searchEquipStaticsListTotCnt(EquipStaticsInVO param);
    
    public RtnVO selectQualityTotStatics(QualityStaticsInVO param);
    public RtnVO selectDeliveryTotStatics(DeliveryStaticsInVO param);
}
