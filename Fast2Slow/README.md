# 單bit跨時域分析（快時鐘到慢時鐘）


由於快時鐘訊號頻率變化快，可能導致滿時鐘無法採集到快時鐘的資料，此時需要利用脈衝同步器進行訊號傳輸

題目鏈接：
<a href = "https://www.nowcoder.com/practice/b7f37e6c55e24478aef4ec2d738bbf07?tpId=302&tqId=5000594&ru=/exam/oj&qru=/ta/verilog-advanced/question-ranking&sourceUrl=%2Fexam%2Foj%3Ftab%3DVerilog%25E7%25AF%2587%26topicId%3D302%26fromPut%3Dpc_zh_s_1540795715">VL49 脉冲同步电路</a>


## 時序圖

利用Reg打兩拍機制將訊號往後延遲以便，慢時鐘能夠接收到訊號

### 為何要打兩拍

為了避免亞穩態(metastability)發生，打一拍亞穩態發生幾率大，而打三拍效果沒有比較好

![image](https://github.com/aa389393/Verilog_example/assets/64916523/88754c1c-65dd-4bd0-9faf-ba89c8808358)


圖片來源 ： https://blog.csdn.net/SummerXRT/article/details/118874138


## 模擬結果

![image](https://github.com/aa389393/Verilog_example/assets/64916523/36849dcf-e618-4dfb-b903-54798cef8f50)

圖片來源 ： https://blog.csdn.net/SummerXRT/article/details/118874138


q1進行打一拍

q2為打第二拍

q3為打第三拍

需要打到第三拍是為了做邊沿檢測，若使用q1、q2進行邊沿檢測會有問題，q1發生亞穩態幾率太大

![image](https://github.com/aa389393/Verilog_example/assets/64916523/18121d1d-9342-4fc3-9fe9-ba929e7bca76)
