// Meriken's Tripcode Engine 2.0.0
// Copyright (c) 2011-2015 Meriken.Z. <meriken.2ch@gmail.com>
//
// The initial versions of this software were based on:
// CUDA SHA-1 Tripper 0.2.1
// Copyright (c) 2009 Horo/.IBXjcg
// 
// The code that deals with DES decryption is partially adopted from:
// John the Ripper password cracker
// Copyright (c) 1996-2002, 2005, 2010 by Solar Designer
// DeepLearningJohnDoe's fork of Meriken's Tripcode Engine
// Copyright (c) 2015 by <deeplearningjohndoe at gmail.com>
//
// The code that deals with SHA-1 hash generation is partially adopted from:
// sha_digest-2.2
// Copyright (C) 2009 Jens Thoms Toerring <jt@toerring.de>
// VecTripper 
// Copyright (C) 2011 tmkk <tmkk@smoug.net>
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.



#include "MerikensTripcodeEngine.h"

#ifdef CUDA_DES_ENABLE_MULTIPLE_KERNELS_MODE

#include "CUDA10_Registers_Kernel_Common.h"

#define SALT 1024
#include "CUDA10_Registers_Kernel.h"
#define SALT 1025
#include "CUDA10_Registers_Kernel.h"
#define SALT 1026
#include "CUDA10_Registers_Kernel.h"
#define SALT 1027
#include "CUDA10_Registers_Kernel.h"
#define SALT 1028
#include "CUDA10_Registers_Kernel.h"
#define SALT 1029
#include "CUDA10_Registers_Kernel.h"
#define SALT 1030
#include "CUDA10_Registers_Kernel.h"
#define SALT 1031
#include "CUDA10_Registers_Kernel.h"
#define SALT 1032
#include "CUDA10_Registers_Kernel.h"
#define SALT 1033
#include "CUDA10_Registers_Kernel.h"
#define SALT 1034
#include "CUDA10_Registers_Kernel.h"
#define SALT 1035
#include "CUDA10_Registers_Kernel.h"
#define SALT 1036
#include "CUDA10_Registers_Kernel.h"
#define SALT 1037
#include "CUDA10_Registers_Kernel.h"
#define SALT 1038
#include "CUDA10_Registers_Kernel.h"
#define SALT 1039
#include "CUDA10_Registers_Kernel.h"
#define SALT 1040
#include "CUDA10_Registers_Kernel.h"
#define SALT 1041
#include "CUDA10_Registers_Kernel.h"
#define SALT 1042
#include "CUDA10_Registers_Kernel.h"
#define SALT 1043
#include "CUDA10_Registers_Kernel.h"
#define SALT 1044
#include "CUDA10_Registers_Kernel.h"
#define SALT 1045
#include "CUDA10_Registers_Kernel.h"
#define SALT 1046
#include "CUDA10_Registers_Kernel.h"
#define SALT 1047
#include "CUDA10_Registers_Kernel.h"
#define SALT 1048
#include "CUDA10_Registers_Kernel.h"
#define SALT 1049
#include "CUDA10_Registers_Kernel.h"
#define SALT 1050
#include "CUDA10_Registers_Kernel.h"
#define SALT 1051
#include "CUDA10_Registers_Kernel.h"
#define SALT 1052
#include "CUDA10_Registers_Kernel.h"
#define SALT 1053
#include "CUDA10_Registers_Kernel.h"
#define SALT 1054
#include "CUDA10_Registers_Kernel.h"
#define SALT 1055
#include "CUDA10_Registers_Kernel.h"
#define SALT 1056
#include "CUDA10_Registers_Kernel.h"
#define SALT 1057
#include "CUDA10_Registers_Kernel.h"
#define SALT 1058
#include "CUDA10_Registers_Kernel.h"
#define SALT 1059
#include "CUDA10_Registers_Kernel.h"
#define SALT 1060
#include "CUDA10_Registers_Kernel.h"
#define SALT 1061
#include "CUDA10_Registers_Kernel.h"
#define SALT 1062
#include "CUDA10_Registers_Kernel.h"
#define SALT 1063
#include "CUDA10_Registers_Kernel.h"
#define SALT 1064
#include "CUDA10_Registers_Kernel.h"
#define SALT 1065
#include "CUDA10_Registers_Kernel.h"
#define SALT 1066
#include "CUDA10_Registers_Kernel.h"
#define SALT 1067
#include "CUDA10_Registers_Kernel.h"
#define SALT 1068
#include "CUDA10_Registers_Kernel.h"
#define SALT 1069
#include "CUDA10_Registers_Kernel.h"
#define SALT 1070
#include "CUDA10_Registers_Kernel.h"
#define SALT 1071
#include "CUDA10_Registers_Kernel.h"
#define SALT 1072
#include "CUDA10_Registers_Kernel.h"
#define SALT 1073
#include "CUDA10_Registers_Kernel.h"
#define SALT 1074
#include "CUDA10_Registers_Kernel.h"
#define SALT 1075
#include "CUDA10_Registers_Kernel.h"
#define SALT 1076
#include "CUDA10_Registers_Kernel.h"
#define SALT 1077
#include "CUDA10_Registers_Kernel.h"
#define SALT 1078
#include "CUDA10_Registers_Kernel.h"
#define SALT 1079
#include "CUDA10_Registers_Kernel.h"
#define SALT 1080
#include "CUDA10_Registers_Kernel.h"
#define SALT 1081
#include "CUDA10_Registers_Kernel.h"
#define SALT 1082
#include "CUDA10_Registers_Kernel.h"
#define SALT 1083
#include "CUDA10_Registers_Kernel.h"
#define SALT 1084
#include "CUDA10_Registers_Kernel.h"
#define SALT 1085
#include "CUDA10_Registers_Kernel.h"
#define SALT 1086
#include "CUDA10_Registers_Kernel.h"
#define SALT 1087
#include "CUDA10_Registers_Kernel.h"
#define SALT 1088
#include "CUDA10_Registers_Kernel.h"
#define SALT 1089
#include "CUDA10_Registers_Kernel.h"
#define SALT 1090
#include "CUDA10_Registers_Kernel.h"
#define SALT 1091
#include "CUDA10_Registers_Kernel.h"
#define SALT 1092
#include "CUDA10_Registers_Kernel.h"
#define SALT 1093
#include "CUDA10_Registers_Kernel.h"
#define SALT 1094
#include "CUDA10_Registers_Kernel.h"
#define SALT 1095
#include "CUDA10_Registers_Kernel.h"
#define SALT 1096
#include "CUDA10_Registers_Kernel.h"
#define SALT 1097
#include "CUDA10_Registers_Kernel.h"
#define SALT 1098
#include "CUDA10_Registers_Kernel.h"
#define SALT 1099
#include "CUDA10_Registers_Kernel.h"
#define SALT 1100
#include "CUDA10_Registers_Kernel.h"
#define SALT 1101
#include "CUDA10_Registers_Kernel.h"
#define SALT 1102
#include "CUDA10_Registers_Kernel.h"
#define SALT 1103
#include "CUDA10_Registers_Kernel.h"
#define SALT 1104
#include "CUDA10_Registers_Kernel.h"
#define SALT 1105
#include "CUDA10_Registers_Kernel.h"
#define SALT 1106
#include "CUDA10_Registers_Kernel.h"
#define SALT 1107
#include "CUDA10_Registers_Kernel.h"
#define SALT 1108
#include "CUDA10_Registers_Kernel.h"
#define SALT 1109
#include "CUDA10_Registers_Kernel.h"
#define SALT 1110
#include "CUDA10_Registers_Kernel.h"
#define SALT 1111
#include "CUDA10_Registers_Kernel.h"
#define SALT 1112
#include "CUDA10_Registers_Kernel.h"
#define SALT 1113
#include "CUDA10_Registers_Kernel.h"
#define SALT 1114
#include "CUDA10_Registers_Kernel.h"
#define SALT 1115
#include "CUDA10_Registers_Kernel.h"
#define SALT 1116
#include "CUDA10_Registers_Kernel.h"
#define SALT 1117
#include "CUDA10_Registers_Kernel.h"
#define SALT 1118
#include "CUDA10_Registers_Kernel.h"
#define SALT 1119
#include "CUDA10_Registers_Kernel.h"
#define SALT 1120
#include "CUDA10_Registers_Kernel.h"
#define SALT 1121
#include "CUDA10_Registers_Kernel.h"
#define SALT 1122
#include "CUDA10_Registers_Kernel.h"
#define SALT 1123
#include "CUDA10_Registers_Kernel.h"
#define SALT 1124
#include "CUDA10_Registers_Kernel.h"
#define SALT 1125
#include "CUDA10_Registers_Kernel.h"
#define SALT 1126
#include "CUDA10_Registers_Kernel.h"
#define SALT 1127
#include "CUDA10_Registers_Kernel.h"
#define SALT 1128
#include "CUDA10_Registers_Kernel.h"
#define SALT 1129
#include "CUDA10_Registers_Kernel.h"
#define SALT 1130
#include "CUDA10_Registers_Kernel.h"
#define SALT 1131
#include "CUDA10_Registers_Kernel.h"
#define SALT 1132
#include "CUDA10_Registers_Kernel.h"
#define SALT 1133
#include "CUDA10_Registers_Kernel.h"
#define SALT 1134
#include "CUDA10_Registers_Kernel.h"
#define SALT 1135
#include "CUDA10_Registers_Kernel.h"
#define SALT 1136
#include "CUDA10_Registers_Kernel.h"
#define SALT 1137
#include "CUDA10_Registers_Kernel.h"
#define SALT 1138
#include "CUDA10_Registers_Kernel.h"
#define SALT 1139
#include "CUDA10_Registers_Kernel.h"
#define SALT 1140
#include "CUDA10_Registers_Kernel.h"
#define SALT 1141
#include "CUDA10_Registers_Kernel.h"
#define SALT 1142
#include "CUDA10_Registers_Kernel.h"
#define SALT 1143
#include "CUDA10_Registers_Kernel.h"
#define SALT 1144
#include "CUDA10_Registers_Kernel.h"
#define SALT 1145
#include "CUDA10_Registers_Kernel.h"
#define SALT 1146
#include "CUDA10_Registers_Kernel.h"
#define SALT 1147
#include "CUDA10_Registers_Kernel.h"
#define SALT 1148
#include "CUDA10_Registers_Kernel.h"
#define SALT 1149
#include "CUDA10_Registers_Kernel.h"
#define SALT 1150
#include "CUDA10_Registers_Kernel.h"
#define SALT 1151
#include "CUDA10_Registers_Kernel.h"
#define SALT 1152
#include "CUDA10_Registers_Kernel.h"
#define SALT 1153
#include "CUDA10_Registers_Kernel.h"
#define SALT 1154
#include "CUDA10_Registers_Kernel.h"
#define SALT 1155
#include "CUDA10_Registers_Kernel.h"
#define SALT 1156
#include "CUDA10_Registers_Kernel.h"
#define SALT 1157
#include "CUDA10_Registers_Kernel.h"
#define SALT 1158
#include "CUDA10_Registers_Kernel.h"
#define SALT 1159
#include "CUDA10_Registers_Kernel.h"
#define SALT 1160
#include "CUDA10_Registers_Kernel.h"
#define SALT 1161
#include "CUDA10_Registers_Kernel.h"
#define SALT 1162
#include "CUDA10_Registers_Kernel.h"
#define SALT 1163
#include "CUDA10_Registers_Kernel.h"
#define SALT 1164
#include "CUDA10_Registers_Kernel.h"
#define SALT 1165
#include "CUDA10_Registers_Kernel.h"
#define SALT 1166
#include "CUDA10_Registers_Kernel.h"
#define SALT 1167
#include "CUDA10_Registers_Kernel.h"
#define SALT 1168
#include "CUDA10_Registers_Kernel.h"
#define SALT 1169
#include "CUDA10_Registers_Kernel.h"
#define SALT 1170
#include "CUDA10_Registers_Kernel.h"
#define SALT 1171
#include "CUDA10_Registers_Kernel.h"
#define SALT 1172
#include "CUDA10_Registers_Kernel.h"
#define SALT 1173
#include "CUDA10_Registers_Kernel.h"
#define SALT 1174
#include "CUDA10_Registers_Kernel.h"
#define SALT 1175
#include "CUDA10_Registers_Kernel.h"
#define SALT 1176
#include "CUDA10_Registers_Kernel.h"
#define SALT 1177
#include "CUDA10_Registers_Kernel.h"
#define SALT 1178
#include "CUDA10_Registers_Kernel.h"
#define SALT 1179
#include "CUDA10_Registers_Kernel.h"
#define SALT 1180
#include "CUDA10_Registers_Kernel.h"
#define SALT 1181
#include "CUDA10_Registers_Kernel.h"
#define SALT 1182
#include "CUDA10_Registers_Kernel.h"
#define SALT 1183
#include "CUDA10_Registers_Kernel.h"
#define SALT 1184
#include "CUDA10_Registers_Kernel.h"
#define SALT 1185
#include "CUDA10_Registers_Kernel.h"
#define SALT 1186
#include "CUDA10_Registers_Kernel.h"
#define SALT 1187
#include "CUDA10_Registers_Kernel.h"
#define SALT 1188
#include "CUDA10_Registers_Kernel.h"
#define SALT 1189
#include "CUDA10_Registers_Kernel.h"
#define SALT 1190
#include "CUDA10_Registers_Kernel.h"
#define SALT 1191
#include "CUDA10_Registers_Kernel.h"
#define SALT 1192
#include "CUDA10_Registers_Kernel.h"
#define SALT 1193
#include "CUDA10_Registers_Kernel.h"
#define SALT 1194
#include "CUDA10_Registers_Kernel.h"
#define SALT 1195
#include "CUDA10_Registers_Kernel.h"
#define SALT 1196
#include "CUDA10_Registers_Kernel.h"
#define SALT 1197
#include "CUDA10_Registers_Kernel.h"
#define SALT 1198
#include "CUDA10_Registers_Kernel.h"
#define SALT 1199
#include "CUDA10_Registers_Kernel.h"
#define SALT 1200
#include "CUDA10_Registers_Kernel.h"
#define SALT 1201
#include "CUDA10_Registers_Kernel.h"
#define SALT 1202
#include "CUDA10_Registers_Kernel.h"
#define SALT 1203
#include "CUDA10_Registers_Kernel.h"
#define SALT 1204
#include "CUDA10_Registers_Kernel.h"
#define SALT 1205
#include "CUDA10_Registers_Kernel.h"
#define SALT 1206
#include "CUDA10_Registers_Kernel.h"
#define SALT 1207
#include "CUDA10_Registers_Kernel.h"
#define SALT 1208
#include "CUDA10_Registers_Kernel.h"
#define SALT 1209
#include "CUDA10_Registers_Kernel.h"
#define SALT 1210
#include "CUDA10_Registers_Kernel.h"
#define SALT 1211
#include "CUDA10_Registers_Kernel.h"
#define SALT 1212
#include "CUDA10_Registers_Kernel.h"
#define SALT 1213
#include "CUDA10_Registers_Kernel.h"
#define SALT 1214
#include "CUDA10_Registers_Kernel.h"
#define SALT 1215
#include "CUDA10_Registers_Kernel.h"
#define SALT 1216
#include "CUDA10_Registers_Kernel.h"
#define SALT 1217
#include "CUDA10_Registers_Kernel.h"
#define SALT 1218
#include "CUDA10_Registers_Kernel.h"
#define SALT 1219
#include "CUDA10_Registers_Kernel.h"
#define SALT 1220
#include "CUDA10_Registers_Kernel.h"
#define SALT 1221
#include "CUDA10_Registers_Kernel.h"
#define SALT 1222
#include "CUDA10_Registers_Kernel.h"
#define SALT 1223
#include "CUDA10_Registers_Kernel.h"
#define SALT 1224
#include "CUDA10_Registers_Kernel.h"
#define SALT 1225
#include "CUDA10_Registers_Kernel.h"
#define SALT 1226
#include "CUDA10_Registers_Kernel.h"
#define SALT 1227
#include "CUDA10_Registers_Kernel.h"
#define SALT 1228
#include "CUDA10_Registers_Kernel.h"
#define SALT 1229
#include "CUDA10_Registers_Kernel.h"
#define SALT 1230
#include "CUDA10_Registers_Kernel.h"
#define SALT 1231
#include "CUDA10_Registers_Kernel.h"
#define SALT 1232
#include "CUDA10_Registers_Kernel.h"
#define SALT 1233
#include "CUDA10_Registers_Kernel.h"
#define SALT 1234
#include "CUDA10_Registers_Kernel.h"
#define SALT 1235
#include "CUDA10_Registers_Kernel.h"
#define SALT 1236
#include "CUDA10_Registers_Kernel.h"
#define SALT 1237
#include "CUDA10_Registers_Kernel.h"
#define SALT 1238
#include "CUDA10_Registers_Kernel.h"
#define SALT 1239
#include "CUDA10_Registers_Kernel.h"
#define SALT 1240
#include "CUDA10_Registers_Kernel.h"
#define SALT 1241
#include "CUDA10_Registers_Kernel.h"
#define SALT 1242
#include "CUDA10_Registers_Kernel.h"
#define SALT 1243
#include "CUDA10_Registers_Kernel.h"
#define SALT 1244
#include "CUDA10_Registers_Kernel.h"
#define SALT 1245
#include "CUDA10_Registers_Kernel.h"
#define SALT 1246
#include "CUDA10_Registers_Kernel.h"
#define SALT 1247
#include "CUDA10_Registers_Kernel.h"
#define SALT 1248
#include "CUDA10_Registers_Kernel.h"
#define SALT 1249
#include "CUDA10_Registers_Kernel.h"
#define SALT 1250
#include "CUDA10_Registers_Kernel.h"
#define SALT 1251
#include "CUDA10_Registers_Kernel.h"
#define SALT 1252
#include "CUDA10_Registers_Kernel.h"
#define SALT 1253
#include "CUDA10_Registers_Kernel.h"
#define SALT 1254
#include "CUDA10_Registers_Kernel.h"
#define SALT 1255
#include "CUDA10_Registers_Kernel.h"
#define SALT 1256
#include "CUDA10_Registers_Kernel.h"
#define SALT 1257
#include "CUDA10_Registers_Kernel.h"
#define SALT 1258
#include "CUDA10_Registers_Kernel.h"
#define SALT 1259
#include "CUDA10_Registers_Kernel.h"
#define SALT 1260
#include "CUDA10_Registers_Kernel.h"
#define SALT 1261
#include "CUDA10_Registers_Kernel.h"
#define SALT 1262
#include "CUDA10_Registers_Kernel.h"
#define SALT 1263
#include "CUDA10_Registers_Kernel.h"
#define SALT 1264
#include "CUDA10_Registers_Kernel.h"
#define SALT 1265
#include "CUDA10_Registers_Kernel.h"
#define SALT 1266
#include "CUDA10_Registers_Kernel.h"
#define SALT 1267
#include "CUDA10_Registers_Kernel.h"
#define SALT 1268
#include "CUDA10_Registers_Kernel.h"
#define SALT 1269
#include "CUDA10_Registers_Kernel.h"
#define SALT 1270
#include "CUDA10_Registers_Kernel.h"
#define SALT 1271
#include "CUDA10_Registers_Kernel.h"
#define SALT 1272
#include "CUDA10_Registers_Kernel.h"
#define SALT 1273
#include "CUDA10_Registers_Kernel.h"
#define SALT 1274
#include "CUDA10_Registers_Kernel.h"
#define SALT 1275
#include "CUDA10_Registers_Kernel.h"
#define SALT 1276
#include "CUDA10_Registers_Kernel.h"
#define SALT 1277
#include "CUDA10_Registers_Kernel.h"
#define SALT 1278
#include "CUDA10_Registers_Kernel.h"
#define SALT 1279
#include "CUDA10_Registers_Kernel.h"
#define SALT 1280
#include "CUDA10_Registers_Kernel.h"
#define SALT 1281
#include "CUDA10_Registers_Kernel.h"
#define SALT 1282
#include "CUDA10_Registers_Kernel.h"
#define SALT 1283
#include "CUDA10_Registers_Kernel.h"
#define SALT 1284
#include "CUDA10_Registers_Kernel.h"
#define SALT 1285
#include "CUDA10_Registers_Kernel.h"
#define SALT 1286
#include "CUDA10_Registers_Kernel.h"
#define SALT 1287
#include "CUDA10_Registers_Kernel.h"
#define SALT 1288
#include "CUDA10_Registers_Kernel.h"
#define SALT 1289
#include "CUDA10_Registers_Kernel.h"
#define SALT 1290
#include "CUDA10_Registers_Kernel.h"
#define SALT 1291
#include "CUDA10_Registers_Kernel.h"
#define SALT 1292
#include "CUDA10_Registers_Kernel.h"
#define SALT 1293
#include "CUDA10_Registers_Kernel.h"
#define SALT 1294
#include "CUDA10_Registers_Kernel.h"
#define SALT 1295
#include "CUDA10_Registers_Kernel.h"
#define SALT 1296
#include "CUDA10_Registers_Kernel.h"
#define SALT 1297
#include "CUDA10_Registers_Kernel.h"
#define SALT 1298
#include "CUDA10_Registers_Kernel.h"
#define SALT 1299
#include "CUDA10_Registers_Kernel.h"
#define SALT 1300
#include "CUDA10_Registers_Kernel.h"
#define SALT 1301
#include "CUDA10_Registers_Kernel.h"
#define SALT 1302
#include "CUDA10_Registers_Kernel.h"
#define SALT 1303
#include "CUDA10_Registers_Kernel.h"
#define SALT 1304
#include "CUDA10_Registers_Kernel.h"
#define SALT 1305
#include "CUDA10_Registers_Kernel.h"
#define SALT 1306
#include "CUDA10_Registers_Kernel.h"
#define SALT 1307
#include "CUDA10_Registers_Kernel.h"
#define SALT 1308
#include "CUDA10_Registers_Kernel.h"
#define SALT 1309
#include "CUDA10_Registers_Kernel.h"
#define SALT 1310
#include "CUDA10_Registers_Kernel.h"
#define SALT 1311
#include "CUDA10_Registers_Kernel.h"
#define SALT 1312
#include "CUDA10_Registers_Kernel.h"
#define SALT 1313
#include "CUDA10_Registers_Kernel.h"
#define SALT 1314
#include "CUDA10_Registers_Kernel.h"
#define SALT 1315
#include "CUDA10_Registers_Kernel.h"
#define SALT 1316
#include "CUDA10_Registers_Kernel.h"
#define SALT 1317
#include "CUDA10_Registers_Kernel.h"
#define SALT 1318
#include "CUDA10_Registers_Kernel.h"
#define SALT 1319
#include "CUDA10_Registers_Kernel.h"
#define SALT 1320
#include "CUDA10_Registers_Kernel.h"
#define SALT 1321
#include "CUDA10_Registers_Kernel.h"
#define SALT 1322
#include "CUDA10_Registers_Kernel.h"
#define SALT 1323
#include "CUDA10_Registers_Kernel.h"
#define SALT 1324
#include "CUDA10_Registers_Kernel.h"
#define SALT 1325
#include "CUDA10_Registers_Kernel.h"
#define SALT 1326
#include "CUDA10_Registers_Kernel.h"
#define SALT 1327
#include "CUDA10_Registers_Kernel.h"
#define SALT 1328
#include "CUDA10_Registers_Kernel.h"
#define SALT 1329
#include "CUDA10_Registers_Kernel.h"
#define SALT 1330
#include "CUDA10_Registers_Kernel.h"
#define SALT 1331
#include "CUDA10_Registers_Kernel.h"
#define SALT 1332
#include "CUDA10_Registers_Kernel.h"
#define SALT 1333
#include "CUDA10_Registers_Kernel.h"
#define SALT 1334
#include "CUDA10_Registers_Kernel.h"
#define SALT 1335
#include "CUDA10_Registers_Kernel.h"
#define SALT 1336
#include "CUDA10_Registers_Kernel.h"
#define SALT 1337
#include "CUDA10_Registers_Kernel.h"
#define SALT 1338
#include "CUDA10_Registers_Kernel.h"
#define SALT 1339
#include "CUDA10_Registers_Kernel.h"
#define SALT 1340
#include "CUDA10_Registers_Kernel.h"
#define SALT 1341
#include "CUDA10_Registers_Kernel.h"
#define SALT 1342
#include "CUDA10_Registers_Kernel.h"
#define SALT 1343
#include "CUDA10_Registers_Kernel.h"
#define SALT 1344
#include "CUDA10_Registers_Kernel.h"
#define SALT 1345
#include "CUDA10_Registers_Kernel.h"
#define SALT 1346
#include "CUDA10_Registers_Kernel.h"
#define SALT 1347
#include "CUDA10_Registers_Kernel.h"
#define SALT 1348
#include "CUDA10_Registers_Kernel.h"
#define SALT 1349
#include "CUDA10_Registers_Kernel.h"
#define SALT 1350
#include "CUDA10_Registers_Kernel.h"
#define SALT 1351
#include "CUDA10_Registers_Kernel.h"
#define SALT 1352
#include "CUDA10_Registers_Kernel.h"
#define SALT 1353
#include "CUDA10_Registers_Kernel.h"
#define SALT 1354
#include "CUDA10_Registers_Kernel.h"
#define SALT 1355
#include "CUDA10_Registers_Kernel.h"
#define SALT 1356
#include "CUDA10_Registers_Kernel.h"
#define SALT 1357
#include "CUDA10_Registers_Kernel.h"
#define SALT 1358
#include "CUDA10_Registers_Kernel.h"
#define SALT 1359
#include "CUDA10_Registers_Kernel.h"
#define SALT 1360
#include "CUDA10_Registers_Kernel.h"
#define SALT 1361
#include "CUDA10_Registers_Kernel.h"
#define SALT 1362
#include "CUDA10_Registers_Kernel.h"
#define SALT 1363
#include "CUDA10_Registers_Kernel.h"
#define SALT 1364
#include "CUDA10_Registers_Kernel.h"
#define SALT 1365
#include "CUDA10_Registers_Kernel.h"
#define SALT 1366
#include "CUDA10_Registers_Kernel.h"
#define SALT 1367
#include "CUDA10_Registers_Kernel.h"
#define SALT 1368
#include "CUDA10_Registers_Kernel.h"
#define SALT 1369
#include "CUDA10_Registers_Kernel.h"
#define SALT 1370
#include "CUDA10_Registers_Kernel.h"
#define SALT 1371
#include "CUDA10_Registers_Kernel.h"
#define SALT 1372
#include "CUDA10_Registers_Kernel.h"
#define SALT 1373
#include "CUDA10_Registers_Kernel.h"
#define SALT 1374
#include "CUDA10_Registers_Kernel.h"
#define SALT 1375
#include "CUDA10_Registers_Kernel.h"
#define SALT 1376
#include "CUDA10_Registers_Kernel.h"
#define SALT 1377
#include "CUDA10_Registers_Kernel.h"
#define SALT 1378
#include "CUDA10_Registers_Kernel.h"
#define SALT 1379
#include "CUDA10_Registers_Kernel.h"
#define SALT 1380
#include "CUDA10_Registers_Kernel.h"
#define SALT 1381
#include "CUDA10_Registers_Kernel.h"
#define SALT 1382
#include "CUDA10_Registers_Kernel.h"
#define SALT 1383
#include "CUDA10_Registers_Kernel.h"
#define SALT 1384
#include "CUDA10_Registers_Kernel.h"
#define SALT 1385
#include "CUDA10_Registers_Kernel.h"
#define SALT 1386
#include "CUDA10_Registers_Kernel.h"
#define SALT 1387
#include "CUDA10_Registers_Kernel.h"
#define SALT 1388
#include "CUDA10_Registers_Kernel.h"
#define SALT 1389
#include "CUDA10_Registers_Kernel.h"
#define SALT 1390
#include "CUDA10_Registers_Kernel.h"
#define SALT 1391
#include "CUDA10_Registers_Kernel.h"
#define SALT 1392
#include "CUDA10_Registers_Kernel.h"
#define SALT 1393
#include "CUDA10_Registers_Kernel.h"
#define SALT 1394
#include "CUDA10_Registers_Kernel.h"
#define SALT 1395
#include "CUDA10_Registers_Kernel.h"
#define SALT 1396
#include "CUDA10_Registers_Kernel.h"
#define SALT 1397
#include "CUDA10_Registers_Kernel.h"
#define SALT 1398
#include "CUDA10_Registers_Kernel.h"
#define SALT 1399
#include "CUDA10_Registers_Kernel.h"
#define SALT 1400
#include "CUDA10_Registers_Kernel.h"
#define SALT 1401
#include "CUDA10_Registers_Kernel.h"
#define SALT 1402
#include "CUDA10_Registers_Kernel.h"
#define SALT 1403
#include "CUDA10_Registers_Kernel.h"
#define SALT 1404
#include "CUDA10_Registers_Kernel.h"
#define SALT 1405
#include "CUDA10_Registers_Kernel.h"
#define SALT 1406
#include "CUDA10_Registers_Kernel.h"
#define SALT 1407
#include "CUDA10_Registers_Kernel.h"
#define SALT 1408
#include "CUDA10_Registers_Kernel.h"
#define SALT 1409
#include "CUDA10_Registers_Kernel.h"
#define SALT 1410
#include "CUDA10_Registers_Kernel.h"
#define SALT 1411
#include "CUDA10_Registers_Kernel.h"
#define SALT 1412
#include "CUDA10_Registers_Kernel.h"
#define SALT 1413
#include "CUDA10_Registers_Kernel.h"
#define SALT 1414
#include "CUDA10_Registers_Kernel.h"
#define SALT 1415
#include "CUDA10_Registers_Kernel.h"
#define SALT 1416
#include "CUDA10_Registers_Kernel.h"
#define SALT 1417
#include "CUDA10_Registers_Kernel.h"
#define SALT 1418
#include "CUDA10_Registers_Kernel.h"
#define SALT 1419
#include "CUDA10_Registers_Kernel.h"
#define SALT 1420
#include "CUDA10_Registers_Kernel.h"
#define SALT 1421
#include "CUDA10_Registers_Kernel.h"
#define SALT 1422
#include "CUDA10_Registers_Kernel.h"
#define SALT 1423
#include "CUDA10_Registers_Kernel.h"
#define SALT 1424
#include "CUDA10_Registers_Kernel.h"
#define SALT 1425
#include "CUDA10_Registers_Kernel.h"
#define SALT 1426
#include "CUDA10_Registers_Kernel.h"
#define SALT 1427
#include "CUDA10_Registers_Kernel.h"
#define SALT 1428
#include "CUDA10_Registers_Kernel.h"
#define SALT 1429
#include "CUDA10_Registers_Kernel.h"
#define SALT 1430
#include "CUDA10_Registers_Kernel.h"
#define SALT 1431
#include "CUDA10_Registers_Kernel.h"
#define SALT 1432
#include "CUDA10_Registers_Kernel.h"
#define SALT 1433
#include "CUDA10_Registers_Kernel.h"
#define SALT 1434
#include "CUDA10_Registers_Kernel.h"
#define SALT 1435
#include "CUDA10_Registers_Kernel.h"
#define SALT 1436
#include "CUDA10_Registers_Kernel.h"
#define SALT 1437
#include "CUDA10_Registers_Kernel.h"
#define SALT 1438
#include "CUDA10_Registers_Kernel.h"
#define SALT 1439
#include "CUDA10_Registers_Kernel.h"
#define SALT 1440
#include "CUDA10_Registers_Kernel.h"
#define SALT 1441
#include "CUDA10_Registers_Kernel.h"
#define SALT 1442
#include "CUDA10_Registers_Kernel.h"
#define SALT 1443
#include "CUDA10_Registers_Kernel.h"
#define SALT 1444
#include "CUDA10_Registers_Kernel.h"
#define SALT 1445
#include "CUDA10_Registers_Kernel.h"
#define SALT 1446
#include "CUDA10_Registers_Kernel.h"
#define SALT 1447
#include "CUDA10_Registers_Kernel.h"
#define SALT 1448
#include "CUDA10_Registers_Kernel.h"
#define SALT 1449
#include "CUDA10_Registers_Kernel.h"
#define SALT 1450
#include "CUDA10_Registers_Kernel.h"
#define SALT 1451
#include "CUDA10_Registers_Kernel.h"
#define SALT 1452
#include "CUDA10_Registers_Kernel.h"
#define SALT 1453
#include "CUDA10_Registers_Kernel.h"
#define SALT 1454
#include "CUDA10_Registers_Kernel.h"
#define SALT 1455
#include "CUDA10_Registers_Kernel.h"
#define SALT 1456
#include "CUDA10_Registers_Kernel.h"
#define SALT 1457
#include "CUDA10_Registers_Kernel.h"
#define SALT 1458
#include "CUDA10_Registers_Kernel.h"
#define SALT 1459
#include "CUDA10_Registers_Kernel.h"
#define SALT 1460
#include "CUDA10_Registers_Kernel.h"
#define SALT 1461
#include "CUDA10_Registers_Kernel.h"
#define SALT 1462
#include "CUDA10_Registers_Kernel.h"
#define SALT 1463
#include "CUDA10_Registers_Kernel.h"
#define SALT 1464
#include "CUDA10_Registers_Kernel.h"
#define SALT 1465
#include "CUDA10_Registers_Kernel.h"
#define SALT 1466
#include "CUDA10_Registers_Kernel.h"
#define SALT 1467
#include "CUDA10_Registers_Kernel.h"
#define SALT 1468
#include "CUDA10_Registers_Kernel.h"
#define SALT 1469
#include "CUDA10_Registers_Kernel.h"
#define SALT 1470
#include "CUDA10_Registers_Kernel.h"
#define SALT 1471
#include "CUDA10_Registers_Kernel.h"
#define SALT 1472
#include "CUDA10_Registers_Kernel.h"
#define SALT 1473
#include "CUDA10_Registers_Kernel.h"
#define SALT 1474
#include "CUDA10_Registers_Kernel.h"
#define SALT 1475
#include "CUDA10_Registers_Kernel.h"
#define SALT 1476
#include "CUDA10_Registers_Kernel.h"
#define SALT 1477
#include "CUDA10_Registers_Kernel.h"
#define SALT 1478
#include "CUDA10_Registers_Kernel.h"
#define SALT 1479
#include "CUDA10_Registers_Kernel.h"
#define SALT 1480
#include "CUDA10_Registers_Kernel.h"
#define SALT 1481
#include "CUDA10_Registers_Kernel.h"
#define SALT 1482
#include "CUDA10_Registers_Kernel.h"
#define SALT 1483
#include "CUDA10_Registers_Kernel.h"
#define SALT 1484
#include "CUDA10_Registers_Kernel.h"
#define SALT 1485
#include "CUDA10_Registers_Kernel.h"
#define SALT 1486
#include "CUDA10_Registers_Kernel.h"
#define SALT 1487
#include "CUDA10_Registers_Kernel.h"
#define SALT 1488
#include "CUDA10_Registers_Kernel.h"
#define SALT 1489
#include "CUDA10_Registers_Kernel.h"
#define SALT 1490
#include "CUDA10_Registers_Kernel.h"
#define SALT 1491
#include "CUDA10_Registers_Kernel.h"
#define SALT 1492
#include "CUDA10_Registers_Kernel.h"
#define SALT 1493
#include "CUDA10_Registers_Kernel.h"
#define SALT 1494
#include "CUDA10_Registers_Kernel.h"
#define SALT 1495
#include "CUDA10_Registers_Kernel.h"
#define SALT 1496
#include "CUDA10_Registers_Kernel.h"
#define SALT 1497
#include "CUDA10_Registers_Kernel.h"
#define SALT 1498
#include "CUDA10_Registers_Kernel.h"
#define SALT 1499
#include "CUDA10_Registers_Kernel.h"
#define SALT 1500
#include "CUDA10_Registers_Kernel.h"
#define SALT 1501
#include "CUDA10_Registers_Kernel.h"
#define SALT 1502
#include "CUDA10_Registers_Kernel.h"
#define SALT 1503
#include "CUDA10_Registers_Kernel.h"
#define SALT 1504
#include "CUDA10_Registers_Kernel.h"
#define SALT 1505
#include "CUDA10_Registers_Kernel.h"
#define SALT 1506
#include "CUDA10_Registers_Kernel.h"
#define SALT 1507
#include "CUDA10_Registers_Kernel.h"
#define SALT 1508
#include "CUDA10_Registers_Kernel.h"
#define SALT 1509
#include "CUDA10_Registers_Kernel.h"
#define SALT 1510
#include "CUDA10_Registers_Kernel.h"
#define SALT 1511
#include "CUDA10_Registers_Kernel.h"
#define SALT 1512
#include "CUDA10_Registers_Kernel.h"
#define SALT 1513
#include "CUDA10_Registers_Kernel.h"
#define SALT 1514
#include "CUDA10_Registers_Kernel.h"
#define SALT 1515
#include "CUDA10_Registers_Kernel.h"
#define SALT 1516
#include "CUDA10_Registers_Kernel.h"
#define SALT 1517
#include "CUDA10_Registers_Kernel.h"
#define SALT 1518
#include "CUDA10_Registers_Kernel.h"
#define SALT 1519
#include "CUDA10_Registers_Kernel.h"
#define SALT 1520
#include "CUDA10_Registers_Kernel.h"
#define SALT 1521
#include "CUDA10_Registers_Kernel.h"
#define SALT 1522
#include "CUDA10_Registers_Kernel.h"
#define SALT 1523
#include "CUDA10_Registers_Kernel.h"
#define SALT 1524
#include "CUDA10_Registers_Kernel.h"
#define SALT 1525
#include "CUDA10_Registers_Kernel.h"
#define SALT 1526
#include "CUDA10_Registers_Kernel.h"
#define SALT 1527
#include "CUDA10_Registers_Kernel.h"
#define SALT 1528
#include "CUDA10_Registers_Kernel.h"
#define SALT 1529
#include "CUDA10_Registers_Kernel.h"
#define SALT 1530
#include "CUDA10_Registers_Kernel.h"
#define SALT 1531
#include "CUDA10_Registers_Kernel.h"
#define SALT 1532
#include "CUDA10_Registers_Kernel.h"
#define SALT 1533
#include "CUDA10_Registers_Kernel.h"
#define SALT 1534
#include "CUDA10_Registers_Kernel.h"
#define SALT 1535
#include "CUDA10_Registers_Kernel.h"



void CUDA_DES_InitializeKernelLauncher2()
{
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,    compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
}

void CUDA_DES_LaunchKernel2(
	unsigned int numBlocksPerGrid,
	cudaDeviceProp CUDADeviceProperties,
	cudaStream_t currentStream,
	unsigned char *cudaPassCountArray,
	unsigned char *cudaTripcodeIndexArray,
	unsigned int *cudaTripcodeChunkArray,
	unsigned int numTripcodeChunk,
	int intSalt,
	unsigned char *cudaKey0Array,
	unsigned char *cudaKey7Array,
	DES_Vector *cudaKeyVectorsFrom49To55,
	unsigned char *cudaKeyAndRandomBytes,
	int searchMode)
{
	dim3 dimGrid(numBlocksPerGrid);
	dim3 dimBlock(CUDA_DES_NUM_THREADS_PER_BLOCK);
	switch (intSalt) {
	case 1024: LAUNCH_KERNEL(1024); break;
	case 1025: LAUNCH_KERNEL(1025); break;
	case 1026: LAUNCH_KERNEL(1026); break;
	case 1027: LAUNCH_KERNEL(1027); break;
	case 1028: LAUNCH_KERNEL(1028); break;
	case 1029: LAUNCH_KERNEL(1029); break;
	case 1030: LAUNCH_KERNEL(1030); break;
	case 1031: LAUNCH_KERNEL(1031); break;
	case 1032: LAUNCH_KERNEL(1032); break;
	case 1033: LAUNCH_KERNEL(1033); break;
	case 1034: LAUNCH_KERNEL(1034); break;
	case 1035: LAUNCH_KERNEL(1035); break;
	case 1036: LAUNCH_KERNEL(1036); break;
	case 1037: LAUNCH_KERNEL(1037); break;
	case 1038: LAUNCH_KERNEL(1038); break;
	case 1039: LAUNCH_KERNEL(1039); break;
	case 1040: LAUNCH_KERNEL(1040); break;
	case 1041: LAUNCH_KERNEL(1041); break;
	case 1042: LAUNCH_KERNEL(1042); break;
	case 1043: LAUNCH_KERNEL(1043); break;
	case 1044: LAUNCH_KERNEL(1044); break;
	case 1045: LAUNCH_KERNEL(1045); break;
	case 1046: LAUNCH_KERNEL(1046); break;
	case 1047: LAUNCH_KERNEL(1047); break;
	case 1048: LAUNCH_KERNEL(1048); break;
	case 1049: LAUNCH_KERNEL(1049); break;
	case 1050: LAUNCH_KERNEL(1050); break;
	case 1051: LAUNCH_KERNEL(1051); break;
	case 1052: LAUNCH_KERNEL(1052); break;
	case 1053: LAUNCH_KERNEL(1053); break;
	case 1054: LAUNCH_KERNEL(1054); break;
	case 1055: LAUNCH_KERNEL(1055); break;
	case 1056: LAUNCH_KERNEL(1056); break;
	case 1057: LAUNCH_KERNEL(1057); break;
	case 1058: LAUNCH_KERNEL(1058); break;
	case 1059: LAUNCH_KERNEL(1059); break;
	case 1060: LAUNCH_KERNEL(1060); break;
	case 1061: LAUNCH_KERNEL(1061); break;
	case 1062: LAUNCH_KERNEL(1062); break;
	case 1063: LAUNCH_KERNEL(1063); break;
	case 1064: LAUNCH_KERNEL(1064); break;
	case 1065: LAUNCH_KERNEL(1065); break;
	case 1066: LAUNCH_KERNEL(1066); break;
	case 1067: LAUNCH_KERNEL(1067); break;
	case 1068: LAUNCH_KERNEL(1068); break;
	case 1069: LAUNCH_KERNEL(1069); break;
	case 1070: LAUNCH_KERNEL(1070); break;
	case 1071: LAUNCH_KERNEL(1071); break;
	case 1072: LAUNCH_KERNEL(1072); break;
	case 1073: LAUNCH_KERNEL(1073); break;
	case 1074: LAUNCH_KERNEL(1074); break;
	case 1075: LAUNCH_KERNEL(1075); break;
	case 1076: LAUNCH_KERNEL(1076); break;
	case 1077: LAUNCH_KERNEL(1077); break;
	case 1078: LAUNCH_KERNEL(1078); break;
	case 1079: LAUNCH_KERNEL(1079); break;
	case 1080: LAUNCH_KERNEL(1080); break;
	case 1081: LAUNCH_KERNEL(1081); break;
	case 1082: LAUNCH_KERNEL(1082); break;
	case 1083: LAUNCH_KERNEL(1083); break;
	case 1084: LAUNCH_KERNEL(1084); break;
	case 1085: LAUNCH_KERNEL(1085); break;
	case 1086: LAUNCH_KERNEL(1086); break;
	case 1087: LAUNCH_KERNEL(1087); break;
	case 1088: LAUNCH_KERNEL(1088); break;
	case 1089: LAUNCH_KERNEL(1089); break;
	case 1090: LAUNCH_KERNEL(1090); break;
	case 1091: LAUNCH_KERNEL(1091); break;
	case 1092: LAUNCH_KERNEL(1092); break;
	case 1093: LAUNCH_KERNEL(1093); break;
	case 1094: LAUNCH_KERNEL(1094); break;
	case 1095: LAUNCH_KERNEL(1095); break;
	case 1096: LAUNCH_KERNEL(1096); break;
	case 1097: LAUNCH_KERNEL(1097); break;
	case 1098: LAUNCH_KERNEL(1098); break;
	case 1099: LAUNCH_KERNEL(1099); break;
	case 1100: LAUNCH_KERNEL(1100); break;
	case 1101: LAUNCH_KERNEL(1101); break;
	case 1102: LAUNCH_KERNEL(1102); break;
	case 1103: LAUNCH_KERNEL(1103); break;
	case 1104: LAUNCH_KERNEL(1104); break;
	case 1105: LAUNCH_KERNEL(1105); break;
	case 1106: LAUNCH_KERNEL(1106); break;
	case 1107: LAUNCH_KERNEL(1107); break;
	case 1108: LAUNCH_KERNEL(1108); break;
	case 1109: LAUNCH_KERNEL(1109); break;
	case 1110: LAUNCH_KERNEL(1110); break;
	case 1111: LAUNCH_KERNEL(1111); break;
	case 1112: LAUNCH_KERNEL(1112); break;
	case 1113: LAUNCH_KERNEL(1113); break;
	case 1114: LAUNCH_KERNEL(1114); break;
	case 1115: LAUNCH_KERNEL(1115); break;
	case 1116: LAUNCH_KERNEL(1116); break;
	case 1117: LAUNCH_KERNEL(1117); break;
	case 1118: LAUNCH_KERNEL(1118); break;
	case 1119: LAUNCH_KERNEL(1119); break;
	case 1120: LAUNCH_KERNEL(1120); break;
	case 1121: LAUNCH_KERNEL(1121); break;
	case 1122: LAUNCH_KERNEL(1122); break;
	case 1123: LAUNCH_KERNEL(1123); break;
	case 1124: LAUNCH_KERNEL(1124); break;
	case 1125: LAUNCH_KERNEL(1125); break;
	case 1126: LAUNCH_KERNEL(1126); break;
	case 1127: LAUNCH_KERNEL(1127); break;
	case 1128: LAUNCH_KERNEL(1128); break;
	case 1129: LAUNCH_KERNEL(1129); break;
	case 1130: LAUNCH_KERNEL(1130); break;
	case 1131: LAUNCH_KERNEL(1131); break;
	case 1132: LAUNCH_KERNEL(1132); break;
	case 1133: LAUNCH_KERNEL(1133); break;
	case 1134: LAUNCH_KERNEL(1134); break;
	case 1135: LAUNCH_KERNEL(1135); break;
	case 1136: LAUNCH_KERNEL(1136); break;
	case 1137: LAUNCH_KERNEL(1137); break;
	case 1138: LAUNCH_KERNEL(1138); break;
	case 1139: LAUNCH_KERNEL(1139); break;
	case 1140: LAUNCH_KERNEL(1140); break;
	case 1141: LAUNCH_KERNEL(1141); break;
	case 1142: LAUNCH_KERNEL(1142); break;
	case 1143: LAUNCH_KERNEL(1143); break;
	case 1144: LAUNCH_KERNEL(1144); break;
	case 1145: LAUNCH_KERNEL(1145); break;
	case 1146: LAUNCH_KERNEL(1146); break;
	case 1147: LAUNCH_KERNEL(1147); break;
	case 1148: LAUNCH_KERNEL(1148); break;
	case 1149: LAUNCH_KERNEL(1149); break;
	case 1150: LAUNCH_KERNEL(1150); break;
	case 1151: LAUNCH_KERNEL(1151); break;
	case 1152: LAUNCH_KERNEL(1152); break;
	case 1153: LAUNCH_KERNEL(1153); break;
	case 1154: LAUNCH_KERNEL(1154); break;
	case 1155: LAUNCH_KERNEL(1155); break;
	case 1156: LAUNCH_KERNEL(1156); break;
	case 1157: LAUNCH_KERNEL(1157); break;
	case 1158: LAUNCH_KERNEL(1158); break;
	case 1159: LAUNCH_KERNEL(1159); break;
	case 1160: LAUNCH_KERNEL(1160); break;
	case 1161: LAUNCH_KERNEL(1161); break;
	case 1162: LAUNCH_KERNEL(1162); break;
	case 1163: LAUNCH_KERNEL(1163); break;
	case 1164: LAUNCH_KERNEL(1164); break;
	case 1165: LAUNCH_KERNEL(1165); break;
	case 1166: LAUNCH_KERNEL(1166); break;
	case 1167: LAUNCH_KERNEL(1167); break;
	case 1168: LAUNCH_KERNEL(1168); break;
	case 1169: LAUNCH_KERNEL(1169); break;
	case 1170: LAUNCH_KERNEL(1170); break;
	case 1171: LAUNCH_KERNEL(1171); break;
	case 1172: LAUNCH_KERNEL(1172); break;
	case 1173: LAUNCH_KERNEL(1173); break;
	case 1174: LAUNCH_KERNEL(1174); break;
	case 1175: LAUNCH_KERNEL(1175); break;
	case 1176: LAUNCH_KERNEL(1176); break;
	case 1177: LAUNCH_KERNEL(1177); break;
	case 1178: LAUNCH_KERNEL(1178); break;
	case 1179: LAUNCH_KERNEL(1179); break;
	case 1180: LAUNCH_KERNEL(1180); break;
	case 1181: LAUNCH_KERNEL(1181); break;
	case 1182: LAUNCH_KERNEL(1182); break;
	case 1183: LAUNCH_KERNEL(1183); break;
	case 1184: LAUNCH_KERNEL(1184); break;
	case 1185: LAUNCH_KERNEL(1185); break;
	case 1186: LAUNCH_KERNEL(1186); break;
	case 1187: LAUNCH_KERNEL(1187); break;
	case 1188: LAUNCH_KERNEL(1188); break;
	case 1189: LAUNCH_KERNEL(1189); break;
	case 1190: LAUNCH_KERNEL(1190); break;
	case 1191: LAUNCH_KERNEL(1191); break;
	case 1192: LAUNCH_KERNEL(1192); break;
	case 1193: LAUNCH_KERNEL(1193); break;
	case 1194: LAUNCH_KERNEL(1194); break;
	case 1195: LAUNCH_KERNEL(1195); break;
	case 1196: LAUNCH_KERNEL(1196); break;
	case 1197: LAUNCH_KERNEL(1197); break;
	case 1198: LAUNCH_KERNEL(1198); break;
	case 1199: LAUNCH_KERNEL(1199); break;
	case 1200: LAUNCH_KERNEL(1200); break;
	case 1201: LAUNCH_KERNEL(1201); break;
	case 1202: LAUNCH_KERNEL(1202); break;
	case 1203: LAUNCH_KERNEL(1203); break;
	case 1204: LAUNCH_KERNEL(1204); break;
	case 1205: LAUNCH_KERNEL(1205); break;
	case 1206: LAUNCH_KERNEL(1206); break;
	case 1207: LAUNCH_KERNEL(1207); break;
	case 1208: LAUNCH_KERNEL(1208); break;
	case 1209: LAUNCH_KERNEL(1209); break;
	case 1210: LAUNCH_KERNEL(1210); break;
	case 1211: LAUNCH_KERNEL(1211); break;
	case 1212: LAUNCH_KERNEL(1212); break;
	case 1213: LAUNCH_KERNEL(1213); break;
	case 1214: LAUNCH_KERNEL(1214); break;
	case 1215: LAUNCH_KERNEL(1215); break;
	case 1216: LAUNCH_KERNEL(1216); break;
	case 1217: LAUNCH_KERNEL(1217); break;
	case 1218: LAUNCH_KERNEL(1218); break;
	case 1219: LAUNCH_KERNEL(1219); break;
	case 1220: LAUNCH_KERNEL(1220); break;
	case 1221: LAUNCH_KERNEL(1221); break;
	case 1222: LAUNCH_KERNEL(1222); break;
	case 1223: LAUNCH_KERNEL(1223); break;
	case 1224: LAUNCH_KERNEL(1224); break;
	case 1225: LAUNCH_KERNEL(1225); break;
	case 1226: LAUNCH_KERNEL(1226); break;
	case 1227: LAUNCH_KERNEL(1227); break;
	case 1228: LAUNCH_KERNEL(1228); break;
	case 1229: LAUNCH_KERNEL(1229); break;
	case 1230: LAUNCH_KERNEL(1230); break;
	case 1231: LAUNCH_KERNEL(1231); break;
	case 1232: LAUNCH_KERNEL(1232); break;
	case 1233: LAUNCH_KERNEL(1233); break;
	case 1234: LAUNCH_KERNEL(1234); break;
	case 1235: LAUNCH_KERNEL(1235); break;
	case 1236: LAUNCH_KERNEL(1236); break;
	case 1237: LAUNCH_KERNEL(1237); break;
	case 1238: LAUNCH_KERNEL(1238); break;
	case 1239: LAUNCH_KERNEL(1239); break;
	case 1240: LAUNCH_KERNEL(1240); break;
	case 1241: LAUNCH_KERNEL(1241); break;
	case 1242: LAUNCH_KERNEL(1242); break;
	case 1243: LAUNCH_KERNEL(1243); break;
	case 1244: LAUNCH_KERNEL(1244); break;
	case 1245: LAUNCH_KERNEL(1245); break;
	case 1246: LAUNCH_KERNEL(1246); break;
	case 1247: LAUNCH_KERNEL(1247); break;
	case 1248: LAUNCH_KERNEL(1248); break;
	case 1249: LAUNCH_KERNEL(1249); break;
	case 1250: LAUNCH_KERNEL(1250); break;
	case 1251: LAUNCH_KERNEL(1251); break;
	case 1252: LAUNCH_KERNEL(1252); break;
	case 1253: LAUNCH_KERNEL(1253); break;
	case 1254: LAUNCH_KERNEL(1254); break;
	case 1255: LAUNCH_KERNEL(1255); break;
	case 1256: LAUNCH_KERNEL(1256); break;
	case 1257: LAUNCH_KERNEL(1257); break;
	case 1258: LAUNCH_KERNEL(1258); break;
	case 1259: LAUNCH_KERNEL(1259); break;
	case 1260: LAUNCH_KERNEL(1260); break;
	case 1261: LAUNCH_KERNEL(1261); break;
	case 1262: LAUNCH_KERNEL(1262); break;
	case 1263: LAUNCH_KERNEL(1263); break;
	case 1264: LAUNCH_KERNEL(1264); break;
	case 1265: LAUNCH_KERNEL(1265); break;
	case 1266: LAUNCH_KERNEL(1266); break;
	case 1267: LAUNCH_KERNEL(1267); break;
	case 1268: LAUNCH_KERNEL(1268); break;
	case 1269: LAUNCH_KERNEL(1269); break;
	case 1270: LAUNCH_KERNEL(1270); break;
	case 1271: LAUNCH_KERNEL(1271); break;
	case 1272: LAUNCH_KERNEL(1272); break;
	case 1273: LAUNCH_KERNEL(1273); break;
	case 1274: LAUNCH_KERNEL(1274); break;
	case 1275: LAUNCH_KERNEL(1275); break;
	case 1276: LAUNCH_KERNEL(1276); break;
	case 1277: LAUNCH_KERNEL(1277); break;
	case 1278: LAUNCH_KERNEL(1278); break;
	case 1279: LAUNCH_KERNEL(1279); break;
	case 1280: LAUNCH_KERNEL(1280); break;
	case 1281: LAUNCH_KERNEL(1281); break;
	case 1282: LAUNCH_KERNEL(1282); break;
	case 1283: LAUNCH_KERNEL(1283); break;
	case 1284: LAUNCH_KERNEL(1284); break;
	case 1285: LAUNCH_KERNEL(1285); break;
	case 1286: LAUNCH_KERNEL(1286); break;
	case 1287: LAUNCH_KERNEL(1287); break;
	case 1288: LAUNCH_KERNEL(1288); break;
	case 1289: LAUNCH_KERNEL(1289); break;
	case 1290: LAUNCH_KERNEL(1290); break;
	case 1291: LAUNCH_KERNEL(1291); break;
	case 1292: LAUNCH_KERNEL(1292); break;
	case 1293: LAUNCH_KERNEL(1293); break;
	case 1294: LAUNCH_KERNEL(1294); break;
	case 1295: LAUNCH_KERNEL(1295); break;
	case 1296: LAUNCH_KERNEL(1296); break;
	case 1297: LAUNCH_KERNEL(1297); break;
	case 1298: LAUNCH_KERNEL(1298); break;
	case 1299: LAUNCH_KERNEL(1299); break;
	case 1300: LAUNCH_KERNEL(1300); break;
	case 1301: LAUNCH_KERNEL(1301); break;
	case 1302: LAUNCH_KERNEL(1302); break;
	case 1303: LAUNCH_KERNEL(1303); break;
	case 1304: LAUNCH_KERNEL(1304); break;
	case 1305: LAUNCH_KERNEL(1305); break;
	case 1306: LAUNCH_KERNEL(1306); break;
	case 1307: LAUNCH_KERNEL(1307); break;
	case 1308: LAUNCH_KERNEL(1308); break;
	case 1309: LAUNCH_KERNEL(1309); break;
	case 1310: LAUNCH_KERNEL(1310); break;
	case 1311: LAUNCH_KERNEL(1311); break;
	case 1312: LAUNCH_KERNEL(1312); break;
	case 1313: LAUNCH_KERNEL(1313); break;
	case 1314: LAUNCH_KERNEL(1314); break;
	case 1315: LAUNCH_KERNEL(1315); break;
	case 1316: LAUNCH_KERNEL(1316); break;
	case 1317: LAUNCH_KERNEL(1317); break;
	case 1318: LAUNCH_KERNEL(1318); break;
	case 1319: LAUNCH_KERNEL(1319); break;
	case 1320: LAUNCH_KERNEL(1320); break;
	case 1321: LAUNCH_KERNEL(1321); break;
	case 1322: LAUNCH_KERNEL(1322); break;
	case 1323: LAUNCH_KERNEL(1323); break;
	case 1324: LAUNCH_KERNEL(1324); break;
	case 1325: LAUNCH_KERNEL(1325); break;
	case 1326: LAUNCH_KERNEL(1326); break;
	case 1327: LAUNCH_KERNEL(1327); break;
	case 1328: LAUNCH_KERNEL(1328); break;
	case 1329: LAUNCH_KERNEL(1329); break;
	case 1330: LAUNCH_KERNEL(1330); break;
	case 1331: LAUNCH_KERNEL(1331); break;
	case 1332: LAUNCH_KERNEL(1332); break;
	case 1333: LAUNCH_KERNEL(1333); break;
	case 1334: LAUNCH_KERNEL(1334); break;
	case 1335: LAUNCH_KERNEL(1335); break;
	case 1336: LAUNCH_KERNEL(1336); break;
	case 1337: LAUNCH_KERNEL(1337); break;
	case 1338: LAUNCH_KERNEL(1338); break;
	case 1339: LAUNCH_KERNEL(1339); break;
	case 1340: LAUNCH_KERNEL(1340); break;
	case 1341: LAUNCH_KERNEL(1341); break;
	case 1342: LAUNCH_KERNEL(1342); break;
	case 1343: LAUNCH_KERNEL(1343); break;
	case 1344: LAUNCH_KERNEL(1344); break;
	case 1345: LAUNCH_KERNEL(1345); break;
	case 1346: LAUNCH_KERNEL(1346); break;
	case 1347: LAUNCH_KERNEL(1347); break;
	case 1348: LAUNCH_KERNEL(1348); break;
	case 1349: LAUNCH_KERNEL(1349); break;
	case 1350: LAUNCH_KERNEL(1350); break;
	case 1351: LAUNCH_KERNEL(1351); break;
	case 1352: LAUNCH_KERNEL(1352); break;
	case 1353: LAUNCH_KERNEL(1353); break;
	case 1354: LAUNCH_KERNEL(1354); break;
	case 1355: LAUNCH_KERNEL(1355); break;
	case 1356: LAUNCH_KERNEL(1356); break;
	case 1357: LAUNCH_KERNEL(1357); break;
	case 1358: LAUNCH_KERNEL(1358); break;
	case 1359: LAUNCH_KERNEL(1359); break;
	case 1360: LAUNCH_KERNEL(1360); break;
	case 1361: LAUNCH_KERNEL(1361); break;
	case 1362: LAUNCH_KERNEL(1362); break;
	case 1363: LAUNCH_KERNEL(1363); break;
	case 1364: LAUNCH_KERNEL(1364); break;
	case 1365: LAUNCH_KERNEL(1365); break;
	case 1366: LAUNCH_KERNEL(1366); break;
	case 1367: LAUNCH_KERNEL(1367); break;
	case 1368: LAUNCH_KERNEL(1368); break;
	case 1369: LAUNCH_KERNEL(1369); break;
	case 1370: LAUNCH_KERNEL(1370); break;
	case 1371: LAUNCH_KERNEL(1371); break;
	case 1372: LAUNCH_KERNEL(1372); break;
	case 1373: LAUNCH_KERNEL(1373); break;
	case 1374: LAUNCH_KERNEL(1374); break;
	case 1375: LAUNCH_KERNEL(1375); break;
	case 1376: LAUNCH_KERNEL(1376); break;
	case 1377: LAUNCH_KERNEL(1377); break;
	case 1378: LAUNCH_KERNEL(1378); break;
	case 1379: LAUNCH_KERNEL(1379); break;
	case 1380: LAUNCH_KERNEL(1380); break;
	case 1381: LAUNCH_KERNEL(1381); break;
	case 1382: LAUNCH_KERNEL(1382); break;
	case 1383: LAUNCH_KERNEL(1383); break;
	case 1384: LAUNCH_KERNEL(1384); break;
	case 1385: LAUNCH_KERNEL(1385); break;
	case 1386: LAUNCH_KERNEL(1386); break;
	case 1387: LAUNCH_KERNEL(1387); break;
	case 1388: LAUNCH_KERNEL(1388); break;
	case 1389: LAUNCH_KERNEL(1389); break;
	case 1390: LAUNCH_KERNEL(1390); break;
	case 1391: LAUNCH_KERNEL(1391); break;
	case 1392: LAUNCH_KERNEL(1392); break;
	case 1393: LAUNCH_KERNEL(1393); break;
	case 1394: LAUNCH_KERNEL(1394); break;
	case 1395: LAUNCH_KERNEL(1395); break;
	case 1396: LAUNCH_KERNEL(1396); break;
	case 1397: LAUNCH_KERNEL(1397); break;
	case 1398: LAUNCH_KERNEL(1398); break;
	case 1399: LAUNCH_KERNEL(1399); break;
	case 1400: LAUNCH_KERNEL(1400); break;
	case 1401: LAUNCH_KERNEL(1401); break;
	case 1402: LAUNCH_KERNEL(1402); break;
	case 1403: LAUNCH_KERNEL(1403); break;
	case 1404: LAUNCH_KERNEL(1404); break;
	case 1405: LAUNCH_KERNEL(1405); break;
	case 1406: LAUNCH_KERNEL(1406); break;
	case 1407: LAUNCH_KERNEL(1407); break;
	case 1408: LAUNCH_KERNEL(1408); break;
	case 1409: LAUNCH_KERNEL(1409); break;
	case 1410: LAUNCH_KERNEL(1410); break;
	case 1411: LAUNCH_KERNEL(1411); break;
	case 1412: LAUNCH_KERNEL(1412); break;
	case 1413: LAUNCH_KERNEL(1413); break;
	case 1414: LAUNCH_KERNEL(1414); break;
	case 1415: LAUNCH_KERNEL(1415); break;
	case 1416: LAUNCH_KERNEL(1416); break;
	case 1417: LAUNCH_KERNEL(1417); break;
	case 1418: LAUNCH_KERNEL(1418); break;
	case 1419: LAUNCH_KERNEL(1419); break;
	case 1420: LAUNCH_KERNEL(1420); break;
	case 1421: LAUNCH_KERNEL(1421); break;
	case 1422: LAUNCH_KERNEL(1422); break;
	case 1423: LAUNCH_KERNEL(1423); break;
	case 1424: LAUNCH_KERNEL(1424); break;
	case 1425: LAUNCH_KERNEL(1425); break;
	case 1426: LAUNCH_KERNEL(1426); break;
	case 1427: LAUNCH_KERNEL(1427); break;
	case 1428: LAUNCH_KERNEL(1428); break;
	case 1429: LAUNCH_KERNEL(1429); break;
	case 1430: LAUNCH_KERNEL(1430); break;
	case 1431: LAUNCH_KERNEL(1431); break;
	case 1432: LAUNCH_KERNEL(1432); break;
	case 1433: LAUNCH_KERNEL(1433); break;
	case 1434: LAUNCH_KERNEL(1434); break;
	case 1435: LAUNCH_KERNEL(1435); break;
	case 1436: LAUNCH_KERNEL(1436); break;
	case 1437: LAUNCH_KERNEL(1437); break;
	case 1438: LAUNCH_KERNEL(1438); break;
	case 1439: LAUNCH_KERNEL(1439); break;
	case 1440: LAUNCH_KERNEL(1440); break;
	case 1441: LAUNCH_KERNEL(1441); break;
	case 1442: LAUNCH_KERNEL(1442); break;
	case 1443: LAUNCH_KERNEL(1443); break;
	case 1444: LAUNCH_KERNEL(1444); break;
	case 1445: LAUNCH_KERNEL(1445); break;
	case 1446: LAUNCH_KERNEL(1446); break;
	case 1447: LAUNCH_KERNEL(1447); break;
	case 1448: LAUNCH_KERNEL(1448); break;
	case 1449: LAUNCH_KERNEL(1449); break;
	case 1450: LAUNCH_KERNEL(1450); break;
	case 1451: LAUNCH_KERNEL(1451); break;
	case 1452: LAUNCH_KERNEL(1452); break;
	case 1453: LAUNCH_KERNEL(1453); break;
	case 1454: LAUNCH_KERNEL(1454); break;
	case 1455: LAUNCH_KERNEL(1455); break;
	case 1456: LAUNCH_KERNEL(1456); break;
	case 1457: LAUNCH_KERNEL(1457); break;
	case 1458: LAUNCH_KERNEL(1458); break;
	case 1459: LAUNCH_KERNEL(1459); break;
	case 1460: LAUNCH_KERNEL(1460); break;
	case 1461: LAUNCH_KERNEL(1461); break;
	case 1462: LAUNCH_KERNEL(1462); break;
	case 1463: LAUNCH_KERNEL(1463); break;
	case 1464: LAUNCH_KERNEL(1464); break;
	case 1465: LAUNCH_KERNEL(1465); break;
	case 1466: LAUNCH_KERNEL(1466); break;
	case 1467: LAUNCH_KERNEL(1467); break;
	case 1468: LAUNCH_KERNEL(1468); break;
	case 1469: LAUNCH_KERNEL(1469); break;
	case 1470: LAUNCH_KERNEL(1470); break;
	case 1471: LAUNCH_KERNEL(1471); break;
	case 1472: LAUNCH_KERNEL(1472); break;
	case 1473: LAUNCH_KERNEL(1473); break;
	case 1474: LAUNCH_KERNEL(1474); break;
	case 1475: LAUNCH_KERNEL(1475); break;
	case 1476: LAUNCH_KERNEL(1476); break;
	case 1477: LAUNCH_KERNEL(1477); break;
	case 1478: LAUNCH_KERNEL(1478); break;
	case 1479: LAUNCH_KERNEL(1479); break;
	case 1480: LAUNCH_KERNEL(1480); break;
	case 1481: LAUNCH_KERNEL(1481); break;
	case 1482: LAUNCH_KERNEL(1482); break;
	case 1483: LAUNCH_KERNEL(1483); break;
	case 1484: LAUNCH_KERNEL(1484); break;
	case 1485: LAUNCH_KERNEL(1485); break;
	case 1486: LAUNCH_KERNEL(1486); break;
	case 1487: LAUNCH_KERNEL(1487); break;
	case 1488: LAUNCH_KERNEL(1488); break;
	case 1489: LAUNCH_KERNEL(1489); break;
	case 1490: LAUNCH_KERNEL(1490); break;
	case 1491: LAUNCH_KERNEL(1491); break;
	case 1492: LAUNCH_KERNEL(1492); break;
	case 1493: LAUNCH_KERNEL(1493); break;
	case 1494: LAUNCH_KERNEL(1494); break;
	case 1495: LAUNCH_KERNEL(1495); break;
	case 1496: LAUNCH_KERNEL(1496); break;
	case 1497: LAUNCH_KERNEL(1497); break;
	case 1498: LAUNCH_KERNEL(1498); break;
	case 1499: LAUNCH_KERNEL(1499); break;
	case 1500: LAUNCH_KERNEL(1500); break;
	case 1501: LAUNCH_KERNEL(1501); break;
	case 1502: LAUNCH_KERNEL(1502); break;
	case 1503: LAUNCH_KERNEL(1503); break;
	case 1504: LAUNCH_KERNEL(1504); break;
	case 1505: LAUNCH_KERNEL(1505); break;
	case 1506: LAUNCH_KERNEL(1506); break;
	case 1507: LAUNCH_KERNEL(1507); break;
	case 1508: LAUNCH_KERNEL(1508); break;
	case 1509: LAUNCH_KERNEL(1509); break;
	case 1510: LAUNCH_KERNEL(1510); break;
	case 1511: LAUNCH_KERNEL(1511); break;
	case 1512: LAUNCH_KERNEL(1512); break;
	case 1513: LAUNCH_KERNEL(1513); break;
	case 1514: LAUNCH_KERNEL(1514); break;
	case 1515: LAUNCH_KERNEL(1515); break;
	case 1516: LAUNCH_KERNEL(1516); break;
	case 1517: LAUNCH_KERNEL(1517); break;
	case 1518: LAUNCH_KERNEL(1518); break;
	case 1519: LAUNCH_KERNEL(1519); break;
	case 1520: LAUNCH_KERNEL(1520); break;
	case 1521: LAUNCH_KERNEL(1521); break;
	case 1522: LAUNCH_KERNEL(1522); break;
	case 1523: LAUNCH_KERNEL(1523); break;
	case 1524: LAUNCH_KERNEL(1524); break;
	case 1525: LAUNCH_KERNEL(1525); break;
	case 1526: LAUNCH_KERNEL(1526); break;
	case 1527: LAUNCH_KERNEL(1527); break;
	case 1528: LAUNCH_KERNEL(1528); break;
	case 1529: LAUNCH_KERNEL(1529); break;
	case 1530: LAUNCH_KERNEL(1530); break;
	case 1531: LAUNCH_KERNEL(1531); break;
	case 1532: LAUNCH_KERNEL(1532); break;
	case 1533: LAUNCH_KERNEL(1533); break;
	case 1534: LAUNCH_KERNEL(1534); break;
	case 1535: LAUNCH_KERNEL(1535); break;
	default: ASSERT(FALSE);
	}
}

#endif
