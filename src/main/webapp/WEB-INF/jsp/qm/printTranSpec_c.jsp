<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
.page {
        width: 23cm !important;
        min-height: 29.7cm;
        padding: 0cm;
        margin: 1cm auto;
        background: white;
        /* border-radius: 5px; */
        /* border: 1px #D3D3D3 solid; */
        /* box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); */
     
    }
.watermark1 { 
        position:absolute;
        left: 44%;
        top:  25%;
        width: 150px; 
        min-height: 85px;  
        background-image:url('/PowerMES/resource/images/강동.png');
        opacity: 0.2;
        z-index:999;
    }
.watermark2 { 
        position:absolute;
        left: 44%;
        top:  72%;
        width: 150px; 
        min-height: 85px;  
        background-image:url('/PowerMES/resource/images/강동.png');
        opacity: 0.2;
        z-index:999;
    }
@page {
        size: A4;
        margin: 0;
    }
    
@media print
{
     body * { visibility: hidden; -webkit-print-color-adjust: exact !important;}
     
     #previewTranSpec * { visibility: visible; box-sizing: border-box; -moz-box-sizing: border-box;}
     #previewTranSpec { position: absolute; }
    
    .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    .watermark1 { 
            left: 44%;
            top:  20%;
            margin: 0;
            border: initial;
            border-radius: initial;
            width: 150px; 
            min-height: 85px;  
            box-shadow: initial;
            background: initial;
            page-break-after: always;
            background-image:url('/PowerMES/resource/images/강동.png');
            opacity: 0.2;
            z-index:999;
    }
    
     .watermark2 { 
            left: 44%;
            top:  72%;
            margin: 0;
            border: initial;
            border-radius: initial;
            width: 150px; 
            min-height: 85px;  
            box-shadow: initial;
            background: initial;
            page-break-after: always;
            background-image:url('/PowerMES/resource/images/강동.png');
            opacity: 0.2;
            z-index:999;
    }
}

/*#B7E4F0 푸른색 계열*/
/*#FFC6D9 붉은색 계열*/
.title8s1 {padding: 0rem;font-size: 0.8rem;text-align:center;}
.title9s1 {padding: 0rem;font-size: 0.9rem;text-align:center;}
.title8bs1 {padding: 0rem;font-size: 0.8rem;font-weight: bold !important;text-align:center;color:#5B9BD5;}
.title9bs1 {padding: 0rem;font-size: 0.9rem;font-weight: bold !important;text-align:center;color:#5B9BD5;}

.title8s2 {padding: 0rem;font-size: 0.8rem;text-align:center;}
.title9s2 {padding: 0rem;font-size: 0.9rem;text-align:center;}
.title8bs2 {padding: 0rem;font-size: 0.8rem;font-weight: bold !important;text-align:center;color:#D65F6B;}
.title9bs2 {padding: 0rem;font-size: 0.9rem;font-weight: bold !important;text-align:center;color:#D65F6B;}

.table-border1s {width:100%;border: 2px solid #5B9BD5;padding: 0.1rem;border-color:#5B9BD5;}
.table-border2s {width:100%;border: 2px solid #5B9BD5;padding: 0.1rem;border-color:#D65F6B}

/* .border-left2s {border-left: 2px solid #5B9BD5;} */
/* .border-right2s {border-right: 2px solid #5B9BD5;} */
/* .border-bottom2s {border-bottom: 2px solid #5B9BD5;} */
.padding03 {padding: 0.3rem;}
</style>

<script>
    $(document).ready(function() {
        
         // 팝업 닫기
        $("#brnTranSpecModalClose").click(function() {
            $("#tranSpecModal").hide();
        });
         
         // 인쇄
        $("#btnTranSpecPrint").click(function() {
            window.print();
        });
        
        //-------------------------------------------------------------
        // 거래 명세서 출력 팝업
        //-------------------------------------------------------------
        $("#btnPrintTranSpec").click(function() {
            var chkCnt = $("input:checkbox[name=rowCheckBox]:checked").length;
            
            if( chkCnt == 0 ) {
                cfAlert("선택된 목록이 없습니다.");
                return false;
            }
            
            if( chkCnt > 6 ) {
                cfAlert("거래 명세서 출력은 6개까지만 가능합니다.");
                return false;
            }
            
            // 고객사 체크
            var custList = new Array();
            $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                var custCd = $("#"+$(this).val()+"_custCd").text();
                custList.push(custCd);
            });
            
            if( chkCnt > 1 ) {
                var chkBool = true;
                custList.forEach(function(obj, idx) {
                    if( custList[0] != obj ) {
                        chkBool = false;
                        return;
                    }
                });
                
                if( !chkBool ) {
                    cfAlert("같은 고객사끼리만 거래 명세서 출력이 가능합니다.");
                    return false;
                }
            }
            
            $("#tranSpecModal").show();
            
            // 값 초기화
            $("span[name^='dynamic-']").text("");
            
            //
            var custCdParam;
            $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                custCdParam = $("#"+$(this).val()+"_custCd").text();
            });
            
            // 회사정보조회
            $.ajax({
                url : "<c:url value='/getTranSpecCompanyData.do'/>",
                type: "POST",
//                 data: {businNo:"613-81-78865"},
//                 data: {businNo:"XXX-XX-XXXXX"},
                data:{custCd:custCdParam},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                context:this,
                dataType:"json",
                beforeSend:function(){
                    $("#layoutSidenav").loading();
                },
                success: function(data) {
                    if(!cfCheckRtnObj(data.rtn)) return;
                    
                    $("span[name='dynamic-businNo']").text(data.rtn.obj.businNo);
                    $("span[name='dynamic-mutualNm']").text(data.rtn.obj.mutualNm);
                    $("span[name='dynamic-ceoNm']").text(data.rtn.obj.ceoNm);
                    $("span[name='dynamic-addr']").text(data.rtn.obj.addr);
                    $("span[name='dynamic-businCond']").text(data.rtn.obj.businCond);
                    $("span[name='dynamic-partsCategory']").text(data.rtn.obj.partsCategory);
                    $("span[name='dynamic-telNo']").text(data.rtn.obj.telNo);
                    $("span[name='dynamic-faxNo']").text(data.rtn.obj.faxNo);
                    
                    $("span[name='dynamic-custNm']").text(data.rtn.obj.custNm);
                    $("span[name='dynamic-custAddr']").text(data.rtn.obj.custAddr);
                    $("span[name='dynamic-custCeoNm']").text(data.rtn.obj.custCeoNm);
                    $("span[name='dynamic-custBusinNo']").text(data.rtn.obj.custBusinNo);
                    $("span[name='dynamic-custBusinCond']").text(data.rtn.obj.custBusinCond);
                    $("span[name='dynamic-custPartsCategory']").text(data.rtn.obj.custPartsCategory);
                },
                error: function(request, status, error){
                    console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                    cfAlert('시스템 오류입니다.');
                },
                complete:function(){
                    $("#layoutSidenav").loadingClose();
                }
            });
            
            $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                var lotOutId = this.value;
                
                var custNm        = $("#"+$(this).val()+"_custNm").text();
                var custCd        = $("#"+$(this).val()+"_custCd").text();
                var itemNo        = $("#"+$(this).val()+"_itemNo").text();
                var itemNm        = $("#"+$(this).val()+"_itemNm").text();
                var itemKind      = $("#"+$(this).val()+"_itemKind").text();
                var outsideQty    = Number($("#"+$(this).val()+"_outsideQty").text());
                var itemPrice     = Number($("#"+$(this).val()+"_itemPrice").text());
                var totPrice      = Number(outsideQty) * Number(itemPrice);
                
//                 $("span[name='dynamic-row" + idx + "-col1']").text(itemNo);
                $("span[name='dynamic-row" + idx + "-col1']").text(itemNm);//품명
                $("span[name='dynamic-row" + idx + "-col2']").text(itemKind);//규격
                $("span[name='dynamic-row" + idx + "-col3']").text(cfAddComma(outsideQty));//수량
                $("span[name='dynamic-row" + idx + "-col4']").text("MM");//단위
                $("span[name='dynamic-row" + idx + "-col5']").text(cfAddComma(itemPrice));//단가
                $("span[name='dynamic-row" + idx + "-col6']").text(cfAddComma(totPrice));//공급가
                $("span[name='dynamic-row" + idx + "-col7']").text("");//부가세
                
//                 $("span[name='dynamic-custNm']").text(custNm);
            });
            
            $("span[name='dynamic-deliveryDt']").text(new Date().format("yyyy-MM-dd"));
           // $("#receiver").html($("#provider").html().replace("공급자", "공급받는자"));
            
        });
    });
</script>

<div id="tranSpecModal" class="modal-container">
    <div class="modal-content" >
        <div class="modal-header">
            <div class="txt20">거래 명세서 출력 정보</div>
            <span id="brnTranSpecModalClose" class="modal-close-button">×</span>
        </div>
        
        <div class="card">
        
            <div class="card-header">
                <sapn class="txt20">거래 명세서 양식</sapn>
                <div id="btnTranSpecPrint" class="btn btn-primary btn-sm mr-2" style="float: right;">출력</div>
            </div>
            
            <div id="previewTranSpec" class="card-body page">
              <div class="watermark1"></div>
              <div class="watermark2"></div>
             <div id="provider">
                
                <table border="1" class="table-border1s">
                <thead>
                  <tr>
                    <th class="text-center" width="100%" colspan="10"><span class="title25b"><img alt="" src="<c:url value='/resource/images/거래명세서_B1.png'/>"/></span></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="text-center" style="width:6%" rowspan="4"><span class="title8bs1">공<br>급<br>자</span></td>
                    <td class="text-center" style="width:8%"><span class="title8bs1">등록<br>번호</span></td>
                    <td class="text-center" style="width:31%" colspan="3"><span class="title9" name="dynamic-businNo"></span></td>
                    
                    <td class="text-center" style="width:6%" rowspan="4"><span class="title8bs1">공<br>급<br>받<br>는<br>자<br></span></td>
                    <td class="text-center" style="width:8%" width="4%"><span class="title8bs1">등록<br>번호</span></td>
                    <td class="text-center" style="width:36%" colspan="3"><span class="title9" name="dynamic-custBusinNo"></span></td>
                  </tr>                     
                  <tr>                      
                    <td class="text-center" style="width:8%"><span class="title9bs1">상호</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-mutualNm"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs1">성명</span></td>
                    <td class="text-center" style="width:12%"><span class="title9" name="dynamic-ceoNm"></span></td>
                                            
                    <td class="text-center" style="width:8%"><span class="title9bs1">상호</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-mutualNm"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs1">성명</span></td>
                    <td class="text-center" style="width:15%"><span class="title9" name="dynamic-custCeoNm"></span></td>
                  </tr>                    
                  <tr>                     
                    <td class="text-center" style="width:8%"><span class="title9bs1">주소</span></td>
                    <td class="text-center" style="width:31%"colspan="3"><span class="title9" name="dynamic-addr"></span></td>
                    
                    <td class="text-center" style="width:8%"><span class="title9bs1">주소</span></td>
                    <td class="text-center" style="width:36%"colspan="3"><span class="title9" name="dynamic-custAddr"></span></td>
                  </tr>                     
                  <tr>                      
                    <td class="text-center" style="width:8%"><span class="title9bs1">업태</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-businCond"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs1">종목</span></td>
                    <td class="text-center" style="width:12%"><span class="title9" name="dynamic-partsCategory"></span></td>
                    
                    <td class="text-center" style="width:8%"><span class="title9bs1">업태</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-businCond"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs1">종목</span></td>
                    <td class="text-center" style="width:15%"><span class="title9" name="dynamic-custPartsCategory"></span></td>
                  </tr>
                  </tbody>
                  </table>
                  <table border="1" class="table-border1s">
                  <tr> <!-- style="border-bottom-style:double;" -->
                    <td class="text-center" width="30%" colspan="3"><span class="title9bs1">품명</span></td>
                    <td class="text-center" width="20%" colspan="2"><span class="title9bs1">규격</span></td>
                    <td class="text-center" width="10%"><span class="title9bs1">수량</span></td>
                    <td class="text-center" width="10%"><span class="title9bs1">단위</span></td>
                    <td class="text-center" width="10%"><span class="title9bs1">단가</span></td>
                    <td class="text-center" width="10%"><span class="title9bs1">공급가</span></td>
                    <td class="text-center" width="10%"><span class="title9bs1">부가세</span></td>
                  </tr>
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${i%2 eq 0}"> <c:set var="color" value="#E8F7FB"/></c:when>
                            <c:otherwise><c:set var="color" value="#FFFFFF"/></c:otherwise>
                        </c:choose>
                        
                        <tr style="height: 45px;background-color:${color}">
                            <td  colspan="3" class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col1"></span></td>
                            <td  colspan="2" class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col2"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col3"></span></td>
                            <td class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col4"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col5"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col6"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col7"></span></td>
                        </tr>
                    </c:forEach>

                    <tr style="background-color:lightgrey;"><td  colspan="10"></td></tr>
                 
                </tbody>
                </table>
               
                </div>
                <!-- provider -->
                
                <br/>
                <hr style="border:none;border:1px dashed;"/>
                
                <div id="receiver">
                <table border="1" class="table-border2s">
                <thead>
                  <tr>
                    <th class="text-center" width="100%" colspan="10"><span class="title25b"><img alt="" src="<c:url value='/resource/images/거래명세서_R1.png'/>"/></span></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="text-center" style="width:6%" rowspan="4"><span class="title8bs2">공<br>급<br>자</span></td>
                    <td class="text-center" style="width:8%"><span class="title8bs2">등록<br>번호</span></td>
                    <td class="text-center" style="width:31%" colspan="3"><span class="title9" name="dynamic-businNo"></span></td>
                    
                    <td class="text-center" style="width:6%" rowspan="4"><span class="title8bs2">공<br>급<br>받<br>는<br>자<br></span></td>
                    <td class="text-center" style="width:8%" width="4%"><span class="title8bs2">등록<br>번호</span></td>
                    <td class="text-center" style="width:36%" colspan="3"><span class="title9" name="dynamic-custBusinNo"></span></td>
                  </tr>                     
                  <tr>                      
                    <td class="text-center" style="width:8%"><span class="title9bs2">상호</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-mutualNm"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs2">성명</span></td>
                    <td class="text-center" style="width:12%"><span class="title9" name="dynamic-ceoNm"></span></td>
                                            
                    <td class="text-center" style="width:8%"><span class="title9bs2">상호</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-mutualNm"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs2">성명</span></td>
                    <td class="text-center" style="width:15%"><span class="title9" name="dynamic-custCeoNm"></span></td>
                  </tr>                    
                  <tr>                     
                    <td class="text-center" style="width:8%"><span class="title9bs2">주소</span></td>
                    <td class="text-center" style="width:31%"colspan="3"><span class="title9" name="dynamic-addr"></span></td>
                    
                    <td class="text-center" style="width:8%"><span class="title9bs2">주소</span></td>
                    <td class="text-center" style="width:36%"colspan="3"><span class="title9" name="dynamic-custAddr"></span></td>
                  </tr>                     
                  <tr>                      
                    <td class="text-center" style="width:8%"><span class="title9bs2">업태</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-businCond"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs2">종목</span></td>
                    <td class="text-center" style="width:12%"><span class="title9" name="dynamic-partsCategory"></span></td>
                    
                    <td class="text-center" style="width:8%"><span class="title9bs2">업태</span></td>
                    <td class="text-center" style="width:16%"><span class="title9" name="dynamic-businCond"></span></td>
                    <td class="text-center" style="width:8%"><span class="title9bs2">종목</span></td>
                    <td class="text-center" style="width:15%"><span class="title9" name="dynamic-custPartsCategory"></span></td>
                  </tr>
                  </tbody>
                  </table>
                  <table border="1" class="table-border2s">
                  <tr> <!-- style="border-bottom-style:double;" -->
                    <td class="text-center" width="30%" colspan="3"><span class="title9bs2">품명</span></td>
                    <td class="text-center" width="20%" colspan="2"><span class="title9bs2">규격</span></td>
                    <td class="text-center" width="10%"><span class="title9bs2">수량</span></td>
                    <td class="text-center" width="10%"><span class="title9bs2">단위</span></td>
                    <td class="text-center" width="10%"><span class="title9bs2">단가</span></td>
                    <td class="text-center" width="10%"><span class="title9bs2">공급가</span></td>
                    <td class="text-center" width="10%"><span class="title9bs2">부가세</span></td>
                  </tr>
                  
                     <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${i%2 eq 0}"> <c:set var="color" value="#FFEEF3"/></c:when>
                            <c:otherwise><c:set var="color" value="#FFFFFF"/></c:otherwise>
                        </c:choose>
                        
                        <tr style="height: 45px;background-color:${color}">
                            <td  colspan="3" class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col1"></span></td>
                            <td  colspan="2" class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col2"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col3"></span></td>
                            <td class="padding03 text-center" style="color:black;"><span name="dynamic-row${i}-col4"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col5"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col6"></span></td>
                            <td class="padding03 text-right" style="color:black;"><span name="dynamic-row${i}-col7"></span></td>
                        </tr>
                    </c:forEach>

                    <tr style="background-color:lightgrey;"><td  colspan="10"></td></tr>
                </tbody>
                </table>
                </div>
                <!-- receiver -->
                <div align="right" style="height: 40px;">
                    <div style="margin:10px 0px;padding:5px;width:230px;border: 1px solid #D65F6B;color:#D65F6B;">
                        <span class="title9bs2" style="margin: 3px 140px 1px 0px;">인수자</span><span class="title9bs2">(인)</span>
                    </div>
                </div>
                
            </div>
            <!-- previewTranSpec -->
            
        </div>
        <!-- card -->
        
    </div>
    <!-- modal-content -->
    
</div>
<!-- tranSpecModal -->
    <script>
    
    </script>