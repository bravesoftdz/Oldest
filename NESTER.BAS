        CLS

CP = 825
X = 1!
Y = .75
U = 1.1
Q = 1.3
W = .2
PRINT "                ������� ��������� ��������  "

INPUT "    �����  ��/��                 S = ", S
INPUT "    ��㡨�� १���� ��            T = ", T
INPUT "    ��ਭ� �१�஢���� ��        B = ", B
INPUT "    ��᫮ ��쥢                  Z = ", Z
INPUT "    ������� �१�  ��             D = ", D
INPUT "    ����� ��饭�� �१� ��/��� N = ", N

PZ = (10 * CP * (T ^ X) * (S ^ Y) * (B ^ U) * Z) / ((D ^ Q) * (N ^ W))

PRINT "���� १���� ࠢ�� � ", PZ

 

    PRINT " ������ Esc..."
    DO
    LOOP UNTIL INKEY$ = CHR$(27)    '27 - �� ASCII ��� ��� Esc.
  
   
    INPUT "������ ���������� ������  ��/�� ---->", SMIN
    INPUT "������ ���ᨬ����� ������ ��/�� ---->", SMAX
    DIM PZ(10)                   ' ���ᠭ�� ���ᨢ� ������ ��� ᨫ�
    DIM SM(10)
    J = 0

    SCREEN 12
    PRINT "������ ��/�� ", "  ���� � "

    '横� ���� ᨫ� �� ���. ����� �� ���ᨬ��쭮� �����

    FOR I% = SMIN TO SMAX STEP (SMAX - SMIN) / 9
        SM(J) = I%
 PZ(J) = (10 * CP * (T ^ X) * ((I%) ^ Y) * (B ^ U) * Z) / ((D ^ Q) * (N ^ W))
        PRINT I%, PZ(J)
        J = J + 1
    NEXT I%

      '横� ���� ��ନ஢������ ��䨪�  ᨫ�
      '�� ���. ����� �� ���ᨬ��쭮� �����
    FOR M = 0 TO 8
        X1% = (SM(M) / SM(8)) * 600
        X2% = X1%
        Y1% = 400
        Y2% = 400 - PZ(M) / PZ(8) * 400
        LINE (X1%, Y1%)-(X2%, Y2%), (M + 1)
    NEXT M
    



