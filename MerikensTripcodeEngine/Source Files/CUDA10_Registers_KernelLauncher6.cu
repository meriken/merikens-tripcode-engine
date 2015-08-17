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

#define SALT 3072
#include "CUDA10_Registers_Kernel.h"
#define SALT 3073
#include "CUDA10_Registers_Kernel.h"
#define SALT 3074
#include "CUDA10_Registers_Kernel.h"
#define SALT 3075
#include "CUDA10_Registers_Kernel.h"
#define SALT 3076
#include "CUDA10_Registers_Kernel.h"
#define SALT 3077
#include "CUDA10_Registers_Kernel.h"
#define SALT 3078
#include "CUDA10_Registers_Kernel.h"
#define SALT 3079
#include "CUDA10_Registers_Kernel.h"
#define SALT 3080
#include "CUDA10_Registers_Kernel.h"
#define SALT 3081
#include "CUDA10_Registers_Kernel.h"
#define SALT 3082
#include "CUDA10_Registers_Kernel.h"
#define SALT 3083
#include "CUDA10_Registers_Kernel.h"
#define SALT 3084
#include "CUDA10_Registers_Kernel.h"
#define SALT 3085
#include "CUDA10_Registers_Kernel.h"
#define SALT 3086
#include "CUDA10_Registers_Kernel.h"
#define SALT 3087
#include "CUDA10_Registers_Kernel.h"
#define SALT 3088
#include "CUDA10_Registers_Kernel.h"
#define SALT 3089
#include "CUDA10_Registers_Kernel.h"
#define SALT 3090
#include "CUDA10_Registers_Kernel.h"
#define SALT 3091
#include "CUDA10_Registers_Kernel.h"
#define SALT 3092
#include "CUDA10_Registers_Kernel.h"
#define SALT 3093
#include "CUDA10_Registers_Kernel.h"
#define SALT 3094
#include "CUDA10_Registers_Kernel.h"
#define SALT 3095
#include "CUDA10_Registers_Kernel.h"
#define SALT 3096
#include "CUDA10_Registers_Kernel.h"
#define SALT 3097
#include "CUDA10_Registers_Kernel.h"
#define SALT 3098
#include "CUDA10_Registers_Kernel.h"
#define SALT 3099
#include "CUDA10_Registers_Kernel.h"
#define SALT 3100
#include "CUDA10_Registers_Kernel.h"
#define SALT 3101
#include "CUDA10_Registers_Kernel.h"
#define SALT 3102
#include "CUDA10_Registers_Kernel.h"
#define SALT 3103
#include "CUDA10_Registers_Kernel.h"
#define SALT 3104
#include "CUDA10_Registers_Kernel.h"
#define SALT 3105
#include "CUDA10_Registers_Kernel.h"
#define SALT 3106
#include "CUDA10_Registers_Kernel.h"
#define SALT 3107
#include "CUDA10_Registers_Kernel.h"
#define SALT 3108
#include "CUDA10_Registers_Kernel.h"
#define SALT 3109
#include "CUDA10_Registers_Kernel.h"
#define SALT 3110
#include "CUDA10_Registers_Kernel.h"
#define SALT 3111
#include "CUDA10_Registers_Kernel.h"
#define SALT 3112
#include "CUDA10_Registers_Kernel.h"
#define SALT 3113
#include "CUDA10_Registers_Kernel.h"
#define SALT 3114
#include "CUDA10_Registers_Kernel.h"
#define SALT 3115
#include "CUDA10_Registers_Kernel.h"
#define SALT 3116
#include "CUDA10_Registers_Kernel.h"
#define SALT 3117
#include "CUDA10_Registers_Kernel.h"
#define SALT 3118
#include "CUDA10_Registers_Kernel.h"
#define SALT 3119
#include "CUDA10_Registers_Kernel.h"
#define SALT 3120
#include "CUDA10_Registers_Kernel.h"
#define SALT 3121
#include "CUDA10_Registers_Kernel.h"
#define SALT 3122
#include "CUDA10_Registers_Kernel.h"
#define SALT 3123
#include "CUDA10_Registers_Kernel.h"
#define SALT 3124
#include "CUDA10_Registers_Kernel.h"
#define SALT 3125
#include "CUDA10_Registers_Kernel.h"
#define SALT 3126
#include "CUDA10_Registers_Kernel.h"
#define SALT 3127
#include "CUDA10_Registers_Kernel.h"
#define SALT 3128
#include "CUDA10_Registers_Kernel.h"
#define SALT 3129
#include "CUDA10_Registers_Kernel.h"
#define SALT 3130
#include "CUDA10_Registers_Kernel.h"
#define SALT 3131
#include "CUDA10_Registers_Kernel.h"
#define SALT 3132
#include "CUDA10_Registers_Kernel.h"
#define SALT 3133
#include "CUDA10_Registers_Kernel.h"
#define SALT 3134
#include "CUDA10_Registers_Kernel.h"
#define SALT 3135
#include "CUDA10_Registers_Kernel.h"
#define SALT 3136
#include "CUDA10_Registers_Kernel.h"
#define SALT 3137
#include "CUDA10_Registers_Kernel.h"
#define SALT 3138
#include "CUDA10_Registers_Kernel.h"
#define SALT 3139
#include "CUDA10_Registers_Kernel.h"
#define SALT 3140
#include "CUDA10_Registers_Kernel.h"
#define SALT 3141
#include "CUDA10_Registers_Kernel.h"
#define SALT 3142
#include "CUDA10_Registers_Kernel.h"
#define SALT 3143
#include "CUDA10_Registers_Kernel.h"
#define SALT 3144
#include "CUDA10_Registers_Kernel.h"
#define SALT 3145
#include "CUDA10_Registers_Kernel.h"
#define SALT 3146
#include "CUDA10_Registers_Kernel.h"
#define SALT 3147
#include "CUDA10_Registers_Kernel.h"
#define SALT 3148
#include "CUDA10_Registers_Kernel.h"
#define SALT 3149
#include "CUDA10_Registers_Kernel.h"
#define SALT 3150
#include "CUDA10_Registers_Kernel.h"
#define SALT 3151
#include "CUDA10_Registers_Kernel.h"
#define SALT 3152
#include "CUDA10_Registers_Kernel.h"
#define SALT 3153
#include "CUDA10_Registers_Kernel.h"
#define SALT 3154
#include "CUDA10_Registers_Kernel.h"
#define SALT 3155
#include "CUDA10_Registers_Kernel.h"
#define SALT 3156
#include "CUDA10_Registers_Kernel.h"
#define SALT 3157
#include "CUDA10_Registers_Kernel.h"
#define SALT 3158
#include "CUDA10_Registers_Kernel.h"
#define SALT 3159
#include "CUDA10_Registers_Kernel.h"
#define SALT 3160
#include "CUDA10_Registers_Kernel.h"
#define SALT 3161
#include "CUDA10_Registers_Kernel.h"
#define SALT 3162
#include "CUDA10_Registers_Kernel.h"
#define SALT 3163
#include "CUDA10_Registers_Kernel.h"
#define SALT 3164
#include "CUDA10_Registers_Kernel.h"
#define SALT 3165
#include "CUDA10_Registers_Kernel.h"
#define SALT 3166
#include "CUDA10_Registers_Kernel.h"
#define SALT 3167
#include "CUDA10_Registers_Kernel.h"
#define SALT 3168
#include "CUDA10_Registers_Kernel.h"
#define SALT 3169
#include "CUDA10_Registers_Kernel.h"
#define SALT 3170
#include "CUDA10_Registers_Kernel.h"
#define SALT 3171
#include "CUDA10_Registers_Kernel.h"
#define SALT 3172
#include "CUDA10_Registers_Kernel.h"
#define SALT 3173
#include "CUDA10_Registers_Kernel.h"
#define SALT 3174
#include "CUDA10_Registers_Kernel.h"
#define SALT 3175
#include "CUDA10_Registers_Kernel.h"
#define SALT 3176
#include "CUDA10_Registers_Kernel.h"
#define SALT 3177
#include "CUDA10_Registers_Kernel.h"
#define SALT 3178
#include "CUDA10_Registers_Kernel.h"
#define SALT 3179
#include "CUDA10_Registers_Kernel.h"
#define SALT 3180
#include "CUDA10_Registers_Kernel.h"
#define SALT 3181
#include "CUDA10_Registers_Kernel.h"
#define SALT 3182
#include "CUDA10_Registers_Kernel.h"
#define SALT 3183
#include "CUDA10_Registers_Kernel.h"
#define SALT 3184
#include "CUDA10_Registers_Kernel.h"
#define SALT 3185
#include "CUDA10_Registers_Kernel.h"
#define SALT 3186
#include "CUDA10_Registers_Kernel.h"
#define SALT 3187
#include "CUDA10_Registers_Kernel.h"
#define SALT 3188
#include "CUDA10_Registers_Kernel.h"
#define SALT 3189
#include "CUDA10_Registers_Kernel.h"
#define SALT 3190
#include "CUDA10_Registers_Kernel.h"
#define SALT 3191
#include "CUDA10_Registers_Kernel.h"
#define SALT 3192
#include "CUDA10_Registers_Kernel.h"
#define SALT 3193
#include "CUDA10_Registers_Kernel.h"
#define SALT 3194
#include "CUDA10_Registers_Kernel.h"
#define SALT 3195
#include "CUDA10_Registers_Kernel.h"
#define SALT 3196
#include "CUDA10_Registers_Kernel.h"
#define SALT 3197
#include "CUDA10_Registers_Kernel.h"
#define SALT 3198
#include "CUDA10_Registers_Kernel.h"
#define SALT 3199
#include "CUDA10_Registers_Kernel.h"
#define SALT 3200
#include "CUDA10_Registers_Kernel.h"
#define SALT 3201
#include "CUDA10_Registers_Kernel.h"
#define SALT 3202
#include "CUDA10_Registers_Kernel.h"
#define SALT 3203
#include "CUDA10_Registers_Kernel.h"
#define SALT 3204
#include "CUDA10_Registers_Kernel.h"
#define SALT 3205
#include "CUDA10_Registers_Kernel.h"
#define SALT 3206
#include "CUDA10_Registers_Kernel.h"
#define SALT 3207
#include "CUDA10_Registers_Kernel.h"
#define SALT 3208
#include "CUDA10_Registers_Kernel.h"
#define SALT 3209
#include "CUDA10_Registers_Kernel.h"
#define SALT 3210
#include "CUDA10_Registers_Kernel.h"
#define SALT 3211
#include "CUDA10_Registers_Kernel.h"
#define SALT 3212
#include "CUDA10_Registers_Kernel.h"
#define SALT 3213
#include "CUDA10_Registers_Kernel.h"
#define SALT 3214
#include "CUDA10_Registers_Kernel.h"
#define SALT 3215
#include "CUDA10_Registers_Kernel.h"
#define SALT 3216
#include "CUDA10_Registers_Kernel.h"
#define SALT 3217
#include "CUDA10_Registers_Kernel.h"
#define SALT 3218
#include "CUDA10_Registers_Kernel.h"
#define SALT 3219
#include "CUDA10_Registers_Kernel.h"
#define SALT 3220
#include "CUDA10_Registers_Kernel.h"
#define SALT 3221
#include "CUDA10_Registers_Kernel.h"
#define SALT 3222
#include "CUDA10_Registers_Kernel.h"
#define SALT 3223
#include "CUDA10_Registers_Kernel.h"
#define SALT 3224
#include "CUDA10_Registers_Kernel.h"
#define SALT 3225
#include "CUDA10_Registers_Kernel.h"
#define SALT 3226
#include "CUDA10_Registers_Kernel.h"
#define SALT 3227
#include "CUDA10_Registers_Kernel.h"
#define SALT 3228
#include "CUDA10_Registers_Kernel.h"
#define SALT 3229
#include "CUDA10_Registers_Kernel.h"
#define SALT 3230
#include "CUDA10_Registers_Kernel.h"
#define SALT 3231
#include "CUDA10_Registers_Kernel.h"
#define SALT 3232
#include "CUDA10_Registers_Kernel.h"
#define SALT 3233
#include "CUDA10_Registers_Kernel.h"
#define SALT 3234
#include "CUDA10_Registers_Kernel.h"
#define SALT 3235
#include "CUDA10_Registers_Kernel.h"
#define SALT 3236
#include "CUDA10_Registers_Kernel.h"
#define SALT 3237
#include "CUDA10_Registers_Kernel.h"
#define SALT 3238
#include "CUDA10_Registers_Kernel.h"
#define SALT 3239
#include "CUDA10_Registers_Kernel.h"
#define SALT 3240
#include "CUDA10_Registers_Kernel.h"
#define SALT 3241
#include "CUDA10_Registers_Kernel.h"
#define SALT 3242
#include "CUDA10_Registers_Kernel.h"
#define SALT 3243
#include "CUDA10_Registers_Kernel.h"
#define SALT 3244
#include "CUDA10_Registers_Kernel.h"
#define SALT 3245
#include "CUDA10_Registers_Kernel.h"
#define SALT 3246
#include "CUDA10_Registers_Kernel.h"
#define SALT 3247
#include "CUDA10_Registers_Kernel.h"
#define SALT 3248
#include "CUDA10_Registers_Kernel.h"
#define SALT 3249
#include "CUDA10_Registers_Kernel.h"
#define SALT 3250
#include "CUDA10_Registers_Kernel.h"
#define SALT 3251
#include "CUDA10_Registers_Kernel.h"
#define SALT 3252
#include "CUDA10_Registers_Kernel.h"
#define SALT 3253
#include "CUDA10_Registers_Kernel.h"
#define SALT 3254
#include "CUDA10_Registers_Kernel.h"
#define SALT 3255
#include "CUDA10_Registers_Kernel.h"
#define SALT 3256
#include "CUDA10_Registers_Kernel.h"
#define SALT 3257
#include "CUDA10_Registers_Kernel.h"
#define SALT 3258
#include "CUDA10_Registers_Kernel.h"
#define SALT 3259
#include "CUDA10_Registers_Kernel.h"
#define SALT 3260
#include "CUDA10_Registers_Kernel.h"
#define SALT 3261
#include "CUDA10_Registers_Kernel.h"
#define SALT 3262
#include "CUDA10_Registers_Kernel.h"
#define SALT 3263
#include "CUDA10_Registers_Kernel.h"
#define SALT 3264
#include "CUDA10_Registers_Kernel.h"
#define SALT 3265
#include "CUDA10_Registers_Kernel.h"
#define SALT 3266
#include "CUDA10_Registers_Kernel.h"
#define SALT 3267
#include "CUDA10_Registers_Kernel.h"
#define SALT 3268
#include "CUDA10_Registers_Kernel.h"
#define SALT 3269
#include "CUDA10_Registers_Kernel.h"
#define SALT 3270
#include "CUDA10_Registers_Kernel.h"
#define SALT 3271
#include "CUDA10_Registers_Kernel.h"
#define SALT 3272
#include "CUDA10_Registers_Kernel.h"
#define SALT 3273
#include "CUDA10_Registers_Kernel.h"
#define SALT 3274
#include "CUDA10_Registers_Kernel.h"
#define SALT 3275
#include "CUDA10_Registers_Kernel.h"
#define SALT 3276
#include "CUDA10_Registers_Kernel.h"
#define SALT 3277
#include "CUDA10_Registers_Kernel.h"
#define SALT 3278
#include "CUDA10_Registers_Kernel.h"
#define SALT 3279
#include "CUDA10_Registers_Kernel.h"
#define SALT 3280
#include "CUDA10_Registers_Kernel.h"
#define SALT 3281
#include "CUDA10_Registers_Kernel.h"
#define SALT 3282
#include "CUDA10_Registers_Kernel.h"
#define SALT 3283
#include "CUDA10_Registers_Kernel.h"
#define SALT 3284
#include "CUDA10_Registers_Kernel.h"
#define SALT 3285
#include "CUDA10_Registers_Kernel.h"
#define SALT 3286
#include "CUDA10_Registers_Kernel.h"
#define SALT 3287
#include "CUDA10_Registers_Kernel.h"
#define SALT 3288
#include "CUDA10_Registers_Kernel.h"
#define SALT 3289
#include "CUDA10_Registers_Kernel.h"
#define SALT 3290
#include "CUDA10_Registers_Kernel.h"
#define SALT 3291
#include "CUDA10_Registers_Kernel.h"
#define SALT 3292
#include "CUDA10_Registers_Kernel.h"
#define SALT 3293
#include "CUDA10_Registers_Kernel.h"
#define SALT 3294
#include "CUDA10_Registers_Kernel.h"
#define SALT 3295
#include "CUDA10_Registers_Kernel.h"
#define SALT 3296
#include "CUDA10_Registers_Kernel.h"
#define SALT 3297
#include "CUDA10_Registers_Kernel.h"
#define SALT 3298
#include "CUDA10_Registers_Kernel.h"
#define SALT 3299
#include "CUDA10_Registers_Kernel.h"
#define SALT 3300
#include "CUDA10_Registers_Kernel.h"
#define SALT 3301
#include "CUDA10_Registers_Kernel.h"
#define SALT 3302
#include "CUDA10_Registers_Kernel.h"
#define SALT 3303
#include "CUDA10_Registers_Kernel.h"
#define SALT 3304
#include "CUDA10_Registers_Kernel.h"
#define SALT 3305
#include "CUDA10_Registers_Kernel.h"
#define SALT 3306
#include "CUDA10_Registers_Kernel.h"
#define SALT 3307
#include "CUDA10_Registers_Kernel.h"
#define SALT 3308
#include "CUDA10_Registers_Kernel.h"
#define SALT 3309
#include "CUDA10_Registers_Kernel.h"
#define SALT 3310
#include "CUDA10_Registers_Kernel.h"
#define SALT 3311
#include "CUDA10_Registers_Kernel.h"
#define SALT 3312
#include "CUDA10_Registers_Kernel.h"
#define SALT 3313
#include "CUDA10_Registers_Kernel.h"
#define SALT 3314
#include "CUDA10_Registers_Kernel.h"
#define SALT 3315
#include "CUDA10_Registers_Kernel.h"
#define SALT 3316
#include "CUDA10_Registers_Kernel.h"
#define SALT 3317
#include "CUDA10_Registers_Kernel.h"
#define SALT 3318
#include "CUDA10_Registers_Kernel.h"
#define SALT 3319
#include "CUDA10_Registers_Kernel.h"
#define SALT 3320
#include "CUDA10_Registers_Kernel.h"
#define SALT 3321
#include "CUDA10_Registers_Kernel.h"
#define SALT 3322
#include "CUDA10_Registers_Kernel.h"
#define SALT 3323
#include "CUDA10_Registers_Kernel.h"
#define SALT 3324
#include "CUDA10_Registers_Kernel.h"
#define SALT 3325
#include "CUDA10_Registers_Kernel.h"
#define SALT 3326
#include "CUDA10_Registers_Kernel.h"
#define SALT 3327
#include "CUDA10_Registers_Kernel.h"
#define SALT 3328
#include "CUDA10_Registers_Kernel.h"
#define SALT 3329
#include "CUDA10_Registers_Kernel.h"
#define SALT 3330
#include "CUDA10_Registers_Kernel.h"
#define SALT 3331
#include "CUDA10_Registers_Kernel.h"
#define SALT 3332
#include "CUDA10_Registers_Kernel.h"
#define SALT 3333
#include "CUDA10_Registers_Kernel.h"
#define SALT 3334
#include "CUDA10_Registers_Kernel.h"
#define SALT 3335
#include "CUDA10_Registers_Kernel.h"
#define SALT 3336
#include "CUDA10_Registers_Kernel.h"
#define SALT 3337
#include "CUDA10_Registers_Kernel.h"
#define SALT 3338
#include "CUDA10_Registers_Kernel.h"
#define SALT 3339
#include "CUDA10_Registers_Kernel.h"
#define SALT 3340
#include "CUDA10_Registers_Kernel.h"
#define SALT 3341
#include "CUDA10_Registers_Kernel.h"
#define SALT 3342
#include "CUDA10_Registers_Kernel.h"
#define SALT 3343
#include "CUDA10_Registers_Kernel.h"
#define SALT 3344
#include "CUDA10_Registers_Kernel.h"
#define SALT 3345
#include "CUDA10_Registers_Kernel.h"
#define SALT 3346
#include "CUDA10_Registers_Kernel.h"
#define SALT 3347
#include "CUDA10_Registers_Kernel.h"
#define SALT 3348
#include "CUDA10_Registers_Kernel.h"
#define SALT 3349
#include "CUDA10_Registers_Kernel.h"
#define SALT 3350
#include "CUDA10_Registers_Kernel.h"
#define SALT 3351
#include "CUDA10_Registers_Kernel.h"
#define SALT 3352
#include "CUDA10_Registers_Kernel.h"
#define SALT 3353
#include "CUDA10_Registers_Kernel.h"
#define SALT 3354
#include "CUDA10_Registers_Kernel.h"
#define SALT 3355
#include "CUDA10_Registers_Kernel.h"
#define SALT 3356
#include "CUDA10_Registers_Kernel.h"
#define SALT 3357
#include "CUDA10_Registers_Kernel.h"
#define SALT 3358
#include "CUDA10_Registers_Kernel.h"
#define SALT 3359
#include "CUDA10_Registers_Kernel.h"
#define SALT 3360
#include "CUDA10_Registers_Kernel.h"
#define SALT 3361
#include "CUDA10_Registers_Kernel.h"
#define SALT 3362
#include "CUDA10_Registers_Kernel.h"
#define SALT 3363
#include "CUDA10_Registers_Kernel.h"
#define SALT 3364
#include "CUDA10_Registers_Kernel.h"
#define SALT 3365
#include "CUDA10_Registers_Kernel.h"
#define SALT 3366
#include "CUDA10_Registers_Kernel.h"
#define SALT 3367
#include "CUDA10_Registers_Kernel.h"
#define SALT 3368
#include "CUDA10_Registers_Kernel.h"
#define SALT 3369
#include "CUDA10_Registers_Kernel.h"
#define SALT 3370
#include "CUDA10_Registers_Kernel.h"
#define SALT 3371
#include "CUDA10_Registers_Kernel.h"
#define SALT 3372
#include "CUDA10_Registers_Kernel.h"
#define SALT 3373
#include "CUDA10_Registers_Kernel.h"
#define SALT 3374
#include "CUDA10_Registers_Kernel.h"
#define SALT 3375
#include "CUDA10_Registers_Kernel.h"
#define SALT 3376
#include "CUDA10_Registers_Kernel.h"
#define SALT 3377
#include "CUDA10_Registers_Kernel.h"
#define SALT 3378
#include "CUDA10_Registers_Kernel.h"
#define SALT 3379
#include "CUDA10_Registers_Kernel.h"
#define SALT 3380
#include "CUDA10_Registers_Kernel.h"
#define SALT 3381
#include "CUDA10_Registers_Kernel.h"
#define SALT 3382
#include "CUDA10_Registers_Kernel.h"
#define SALT 3383
#include "CUDA10_Registers_Kernel.h"
#define SALT 3384
#include "CUDA10_Registers_Kernel.h"
#define SALT 3385
#include "CUDA10_Registers_Kernel.h"
#define SALT 3386
#include "CUDA10_Registers_Kernel.h"
#define SALT 3387
#include "CUDA10_Registers_Kernel.h"
#define SALT 3388
#include "CUDA10_Registers_Kernel.h"
#define SALT 3389
#include "CUDA10_Registers_Kernel.h"
#define SALT 3390
#include "CUDA10_Registers_Kernel.h"
#define SALT 3391
#include "CUDA10_Registers_Kernel.h"
#define SALT 3392
#include "CUDA10_Registers_Kernel.h"
#define SALT 3393
#include "CUDA10_Registers_Kernel.h"
#define SALT 3394
#include "CUDA10_Registers_Kernel.h"
#define SALT 3395
#include "CUDA10_Registers_Kernel.h"
#define SALT 3396
#include "CUDA10_Registers_Kernel.h"
#define SALT 3397
#include "CUDA10_Registers_Kernel.h"
#define SALT 3398
#include "CUDA10_Registers_Kernel.h"
#define SALT 3399
#include "CUDA10_Registers_Kernel.h"
#define SALT 3400
#include "CUDA10_Registers_Kernel.h"
#define SALT 3401
#include "CUDA10_Registers_Kernel.h"
#define SALT 3402
#include "CUDA10_Registers_Kernel.h"
#define SALT 3403
#include "CUDA10_Registers_Kernel.h"
#define SALT 3404
#include "CUDA10_Registers_Kernel.h"
#define SALT 3405
#include "CUDA10_Registers_Kernel.h"
#define SALT 3406
#include "CUDA10_Registers_Kernel.h"
#define SALT 3407
#include "CUDA10_Registers_Kernel.h"
#define SALT 3408
#include "CUDA10_Registers_Kernel.h"
#define SALT 3409
#include "CUDA10_Registers_Kernel.h"
#define SALT 3410
#include "CUDA10_Registers_Kernel.h"
#define SALT 3411
#include "CUDA10_Registers_Kernel.h"
#define SALT 3412
#include "CUDA10_Registers_Kernel.h"
#define SALT 3413
#include "CUDA10_Registers_Kernel.h"
#define SALT 3414
#include "CUDA10_Registers_Kernel.h"
#define SALT 3415
#include "CUDA10_Registers_Kernel.h"
#define SALT 3416
#include "CUDA10_Registers_Kernel.h"
#define SALT 3417
#include "CUDA10_Registers_Kernel.h"
#define SALT 3418
#include "CUDA10_Registers_Kernel.h"
#define SALT 3419
#include "CUDA10_Registers_Kernel.h"
#define SALT 3420
#include "CUDA10_Registers_Kernel.h"
#define SALT 3421
#include "CUDA10_Registers_Kernel.h"
#define SALT 3422
#include "CUDA10_Registers_Kernel.h"
#define SALT 3423
#include "CUDA10_Registers_Kernel.h"
#define SALT 3424
#include "CUDA10_Registers_Kernel.h"
#define SALT 3425
#include "CUDA10_Registers_Kernel.h"
#define SALT 3426
#include "CUDA10_Registers_Kernel.h"
#define SALT 3427
#include "CUDA10_Registers_Kernel.h"
#define SALT 3428
#include "CUDA10_Registers_Kernel.h"
#define SALT 3429
#include "CUDA10_Registers_Kernel.h"
#define SALT 3430
#include "CUDA10_Registers_Kernel.h"
#define SALT 3431
#include "CUDA10_Registers_Kernel.h"
#define SALT 3432
#include "CUDA10_Registers_Kernel.h"
#define SALT 3433
#include "CUDA10_Registers_Kernel.h"
#define SALT 3434
#include "CUDA10_Registers_Kernel.h"
#define SALT 3435
#include "CUDA10_Registers_Kernel.h"
#define SALT 3436
#include "CUDA10_Registers_Kernel.h"
#define SALT 3437
#include "CUDA10_Registers_Kernel.h"
#define SALT 3438
#include "CUDA10_Registers_Kernel.h"
#define SALT 3439
#include "CUDA10_Registers_Kernel.h"
#define SALT 3440
#include "CUDA10_Registers_Kernel.h"
#define SALT 3441
#include "CUDA10_Registers_Kernel.h"
#define SALT 3442
#include "CUDA10_Registers_Kernel.h"
#define SALT 3443
#include "CUDA10_Registers_Kernel.h"
#define SALT 3444
#include "CUDA10_Registers_Kernel.h"
#define SALT 3445
#include "CUDA10_Registers_Kernel.h"
#define SALT 3446
#include "CUDA10_Registers_Kernel.h"
#define SALT 3447
#include "CUDA10_Registers_Kernel.h"
#define SALT 3448
#include "CUDA10_Registers_Kernel.h"
#define SALT 3449
#include "CUDA10_Registers_Kernel.h"
#define SALT 3450
#include "CUDA10_Registers_Kernel.h"
#define SALT 3451
#include "CUDA10_Registers_Kernel.h"
#define SALT 3452
#include "CUDA10_Registers_Kernel.h"
#define SALT 3453
#include "CUDA10_Registers_Kernel.h"
#define SALT 3454
#include "CUDA10_Registers_Kernel.h"
#define SALT 3455
#include "CUDA10_Registers_Kernel.h"
#define SALT 3456
#include "CUDA10_Registers_Kernel.h"
#define SALT 3457
#include "CUDA10_Registers_Kernel.h"
#define SALT 3458
#include "CUDA10_Registers_Kernel.h"
#define SALT 3459
#include "CUDA10_Registers_Kernel.h"
#define SALT 3460
#include "CUDA10_Registers_Kernel.h"
#define SALT 3461
#include "CUDA10_Registers_Kernel.h"
#define SALT 3462
#include "CUDA10_Registers_Kernel.h"
#define SALT 3463
#include "CUDA10_Registers_Kernel.h"
#define SALT 3464
#include "CUDA10_Registers_Kernel.h"
#define SALT 3465
#include "CUDA10_Registers_Kernel.h"
#define SALT 3466
#include "CUDA10_Registers_Kernel.h"
#define SALT 3467
#include "CUDA10_Registers_Kernel.h"
#define SALT 3468
#include "CUDA10_Registers_Kernel.h"
#define SALT 3469
#include "CUDA10_Registers_Kernel.h"
#define SALT 3470
#include "CUDA10_Registers_Kernel.h"
#define SALT 3471
#include "CUDA10_Registers_Kernel.h"
#define SALT 3472
#include "CUDA10_Registers_Kernel.h"
#define SALT 3473
#include "CUDA10_Registers_Kernel.h"
#define SALT 3474
#include "CUDA10_Registers_Kernel.h"
#define SALT 3475
#include "CUDA10_Registers_Kernel.h"
#define SALT 3476
#include "CUDA10_Registers_Kernel.h"
#define SALT 3477
#include "CUDA10_Registers_Kernel.h"
#define SALT 3478
#include "CUDA10_Registers_Kernel.h"
#define SALT 3479
#include "CUDA10_Registers_Kernel.h"
#define SALT 3480
#include "CUDA10_Registers_Kernel.h"
#define SALT 3481
#include "CUDA10_Registers_Kernel.h"
#define SALT 3482
#include "CUDA10_Registers_Kernel.h"
#define SALT 3483
#include "CUDA10_Registers_Kernel.h"
#define SALT 3484
#include "CUDA10_Registers_Kernel.h"
#define SALT 3485
#include "CUDA10_Registers_Kernel.h"
#define SALT 3486
#include "CUDA10_Registers_Kernel.h"
#define SALT 3487
#include "CUDA10_Registers_Kernel.h"
#define SALT 3488
#include "CUDA10_Registers_Kernel.h"
#define SALT 3489
#include "CUDA10_Registers_Kernel.h"
#define SALT 3490
#include "CUDA10_Registers_Kernel.h"
#define SALT 3491
#include "CUDA10_Registers_Kernel.h"
#define SALT 3492
#include "CUDA10_Registers_Kernel.h"
#define SALT 3493
#include "CUDA10_Registers_Kernel.h"
#define SALT 3494
#include "CUDA10_Registers_Kernel.h"
#define SALT 3495
#include "CUDA10_Registers_Kernel.h"
#define SALT 3496
#include "CUDA10_Registers_Kernel.h"
#define SALT 3497
#include "CUDA10_Registers_Kernel.h"
#define SALT 3498
#include "CUDA10_Registers_Kernel.h"
#define SALT 3499
#include "CUDA10_Registers_Kernel.h"
#define SALT 3500
#include "CUDA10_Registers_Kernel.h"
#define SALT 3501
#include "CUDA10_Registers_Kernel.h"
#define SALT 3502
#include "CUDA10_Registers_Kernel.h"
#define SALT 3503
#include "CUDA10_Registers_Kernel.h"
#define SALT 3504
#include "CUDA10_Registers_Kernel.h"
#define SALT 3505
#include "CUDA10_Registers_Kernel.h"
#define SALT 3506
#include "CUDA10_Registers_Kernel.h"
#define SALT 3507
#include "CUDA10_Registers_Kernel.h"
#define SALT 3508
#include "CUDA10_Registers_Kernel.h"
#define SALT 3509
#include "CUDA10_Registers_Kernel.h"
#define SALT 3510
#include "CUDA10_Registers_Kernel.h"
#define SALT 3511
#include "CUDA10_Registers_Kernel.h"
#define SALT 3512
#include "CUDA10_Registers_Kernel.h"
#define SALT 3513
#include "CUDA10_Registers_Kernel.h"
#define SALT 3514
#include "CUDA10_Registers_Kernel.h"
#define SALT 3515
#include "CUDA10_Registers_Kernel.h"
#define SALT 3516
#include "CUDA10_Registers_Kernel.h"
#define SALT 3517
#include "CUDA10_Registers_Kernel.h"
#define SALT 3518
#include "CUDA10_Registers_Kernel.h"
#define SALT 3519
#include "CUDA10_Registers_Kernel.h"
#define SALT 3520
#include "CUDA10_Registers_Kernel.h"
#define SALT 3521
#include "CUDA10_Registers_Kernel.h"
#define SALT 3522
#include "CUDA10_Registers_Kernel.h"
#define SALT 3523
#include "CUDA10_Registers_Kernel.h"
#define SALT 3524
#include "CUDA10_Registers_Kernel.h"
#define SALT 3525
#include "CUDA10_Registers_Kernel.h"
#define SALT 3526
#include "CUDA10_Registers_Kernel.h"
#define SALT 3527
#include "CUDA10_Registers_Kernel.h"
#define SALT 3528
#include "CUDA10_Registers_Kernel.h"
#define SALT 3529
#include "CUDA10_Registers_Kernel.h"
#define SALT 3530
#include "CUDA10_Registers_Kernel.h"
#define SALT 3531
#include "CUDA10_Registers_Kernel.h"
#define SALT 3532
#include "CUDA10_Registers_Kernel.h"
#define SALT 3533
#include "CUDA10_Registers_Kernel.h"
#define SALT 3534
#include "CUDA10_Registers_Kernel.h"
#define SALT 3535
#include "CUDA10_Registers_Kernel.h"
#define SALT 3536
#include "CUDA10_Registers_Kernel.h"
#define SALT 3537
#include "CUDA10_Registers_Kernel.h"
#define SALT 3538
#include "CUDA10_Registers_Kernel.h"
#define SALT 3539
#include "CUDA10_Registers_Kernel.h"
#define SALT 3540
#include "CUDA10_Registers_Kernel.h"
#define SALT 3541
#include "CUDA10_Registers_Kernel.h"
#define SALT 3542
#include "CUDA10_Registers_Kernel.h"
#define SALT 3543
#include "CUDA10_Registers_Kernel.h"
#define SALT 3544
#include "CUDA10_Registers_Kernel.h"
#define SALT 3545
#include "CUDA10_Registers_Kernel.h"
#define SALT 3546
#include "CUDA10_Registers_Kernel.h"
#define SALT 3547
#include "CUDA10_Registers_Kernel.h"
#define SALT 3548
#include "CUDA10_Registers_Kernel.h"
#define SALT 3549
#include "CUDA10_Registers_Kernel.h"
#define SALT 3550
#include "CUDA10_Registers_Kernel.h"
#define SALT 3551
#include "CUDA10_Registers_Kernel.h"
#define SALT 3552
#include "CUDA10_Registers_Kernel.h"
#define SALT 3553
#include "CUDA10_Registers_Kernel.h"
#define SALT 3554
#include "CUDA10_Registers_Kernel.h"
#define SALT 3555
#include "CUDA10_Registers_Kernel.h"
#define SALT 3556
#include "CUDA10_Registers_Kernel.h"
#define SALT 3557
#include "CUDA10_Registers_Kernel.h"
#define SALT 3558
#include "CUDA10_Registers_Kernel.h"
#define SALT 3559
#include "CUDA10_Registers_Kernel.h"
#define SALT 3560
#include "CUDA10_Registers_Kernel.h"
#define SALT 3561
#include "CUDA10_Registers_Kernel.h"
#define SALT 3562
#include "CUDA10_Registers_Kernel.h"
#define SALT 3563
#include "CUDA10_Registers_Kernel.h"
#define SALT 3564
#include "CUDA10_Registers_Kernel.h"
#define SALT 3565
#include "CUDA10_Registers_Kernel.h"
#define SALT 3566
#include "CUDA10_Registers_Kernel.h"
#define SALT 3567
#include "CUDA10_Registers_Kernel.h"
#define SALT 3568
#include "CUDA10_Registers_Kernel.h"
#define SALT 3569
#include "CUDA10_Registers_Kernel.h"
#define SALT 3570
#include "CUDA10_Registers_Kernel.h"
#define SALT 3571
#include "CUDA10_Registers_Kernel.h"
#define SALT 3572
#include "CUDA10_Registers_Kernel.h"
#define SALT 3573
#include "CUDA10_Registers_Kernel.h"
#define SALT 3574
#include "CUDA10_Registers_Kernel.h"
#define SALT 3575
#include "CUDA10_Registers_Kernel.h"
#define SALT 3576
#include "CUDA10_Registers_Kernel.h"
#define SALT 3577
#include "CUDA10_Registers_Kernel.h"
#define SALT 3578
#include "CUDA10_Registers_Kernel.h"
#define SALT 3579
#include "CUDA10_Registers_Kernel.h"
#define SALT 3580
#include "CUDA10_Registers_Kernel.h"
#define SALT 3581
#include "CUDA10_Registers_Kernel.h"
#define SALT 3582
#include "CUDA10_Registers_Kernel.h"
#define SALT 3583
#include "CUDA10_Registers_Kernel.h"



void CUDA_DES_InitializeKernelLauncher6()
{
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,    compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
}

void CUDA_DES_LaunchKernel6(
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
	case 3072: LAUNCH_KERNEL(3072); break;
	case 3073: LAUNCH_KERNEL(3073); break;
	case 3074: LAUNCH_KERNEL(3074); break;
	case 3075: LAUNCH_KERNEL(3075); break;
	case 3076: LAUNCH_KERNEL(3076); break;
	case 3077: LAUNCH_KERNEL(3077); break;
	case 3078: LAUNCH_KERNEL(3078); break;
	case 3079: LAUNCH_KERNEL(3079); break;
	case 3080: LAUNCH_KERNEL(3080); break;
	case 3081: LAUNCH_KERNEL(3081); break;
	case 3082: LAUNCH_KERNEL(3082); break;
	case 3083: LAUNCH_KERNEL(3083); break;
	case 3084: LAUNCH_KERNEL(3084); break;
	case 3085: LAUNCH_KERNEL(3085); break;
	case 3086: LAUNCH_KERNEL(3086); break;
	case 3087: LAUNCH_KERNEL(3087); break;
	case 3088: LAUNCH_KERNEL(3088); break;
	case 3089: LAUNCH_KERNEL(3089); break;
	case 3090: LAUNCH_KERNEL(3090); break;
	case 3091: LAUNCH_KERNEL(3091); break;
	case 3092: LAUNCH_KERNEL(3092); break;
	case 3093: LAUNCH_KERNEL(3093); break;
	case 3094: LAUNCH_KERNEL(3094); break;
	case 3095: LAUNCH_KERNEL(3095); break;
	case 3096: LAUNCH_KERNEL(3096); break;
	case 3097: LAUNCH_KERNEL(3097); break;
	case 3098: LAUNCH_KERNEL(3098); break;
	case 3099: LAUNCH_KERNEL(3099); break;
	case 3100: LAUNCH_KERNEL(3100); break;
	case 3101: LAUNCH_KERNEL(3101); break;
	case 3102: LAUNCH_KERNEL(3102); break;
	case 3103: LAUNCH_KERNEL(3103); break;
	case 3104: LAUNCH_KERNEL(3104); break;
	case 3105: LAUNCH_KERNEL(3105); break;
	case 3106: LAUNCH_KERNEL(3106); break;
	case 3107: LAUNCH_KERNEL(3107); break;
	case 3108: LAUNCH_KERNEL(3108); break;
	case 3109: LAUNCH_KERNEL(3109); break;
	case 3110: LAUNCH_KERNEL(3110); break;
	case 3111: LAUNCH_KERNEL(3111); break;
	case 3112: LAUNCH_KERNEL(3112); break;
	case 3113: LAUNCH_KERNEL(3113); break;
	case 3114: LAUNCH_KERNEL(3114); break;
	case 3115: LAUNCH_KERNEL(3115); break;
	case 3116: LAUNCH_KERNEL(3116); break;
	case 3117: LAUNCH_KERNEL(3117); break;
	case 3118: LAUNCH_KERNEL(3118); break;
	case 3119: LAUNCH_KERNEL(3119); break;
	case 3120: LAUNCH_KERNEL(3120); break;
	case 3121: LAUNCH_KERNEL(3121); break;
	case 3122: LAUNCH_KERNEL(3122); break;
	case 3123: LAUNCH_KERNEL(3123); break;
	case 3124: LAUNCH_KERNEL(3124); break;
	case 3125: LAUNCH_KERNEL(3125); break;
	case 3126: LAUNCH_KERNEL(3126); break;
	case 3127: LAUNCH_KERNEL(3127); break;
	case 3128: LAUNCH_KERNEL(3128); break;
	case 3129: LAUNCH_KERNEL(3129); break;
	case 3130: LAUNCH_KERNEL(3130); break;
	case 3131: LAUNCH_KERNEL(3131); break;
	case 3132: LAUNCH_KERNEL(3132); break;
	case 3133: LAUNCH_KERNEL(3133); break;
	case 3134: LAUNCH_KERNEL(3134); break;
	case 3135: LAUNCH_KERNEL(3135); break;
	case 3136: LAUNCH_KERNEL(3136); break;
	case 3137: LAUNCH_KERNEL(3137); break;
	case 3138: LAUNCH_KERNEL(3138); break;
	case 3139: LAUNCH_KERNEL(3139); break;
	case 3140: LAUNCH_KERNEL(3140); break;
	case 3141: LAUNCH_KERNEL(3141); break;
	case 3142: LAUNCH_KERNEL(3142); break;
	case 3143: LAUNCH_KERNEL(3143); break;
	case 3144: LAUNCH_KERNEL(3144); break;
	case 3145: LAUNCH_KERNEL(3145); break;
	case 3146: LAUNCH_KERNEL(3146); break;
	case 3147: LAUNCH_KERNEL(3147); break;
	case 3148: LAUNCH_KERNEL(3148); break;
	case 3149: LAUNCH_KERNEL(3149); break;
	case 3150: LAUNCH_KERNEL(3150); break;
	case 3151: LAUNCH_KERNEL(3151); break;
	case 3152: LAUNCH_KERNEL(3152); break;
	case 3153: LAUNCH_KERNEL(3153); break;
	case 3154: LAUNCH_KERNEL(3154); break;
	case 3155: LAUNCH_KERNEL(3155); break;
	case 3156: LAUNCH_KERNEL(3156); break;
	case 3157: LAUNCH_KERNEL(3157); break;
	case 3158: LAUNCH_KERNEL(3158); break;
	case 3159: LAUNCH_KERNEL(3159); break;
	case 3160: LAUNCH_KERNEL(3160); break;
	case 3161: LAUNCH_KERNEL(3161); break;
	case 3162: LAUNCH_KERNEL(3162); break;
	case 3163: LAUNCH_KERNEL(3163); break;
	case 3164: LAUNCH_KERNEL(3164); break;
	case 3165: LAUNCH_KERNEL(3165); break;
	case 3166: LAUNCH_KERNEL(3166); break;
	case 3167: LAUNCH_KERNEL(3167); break;
	case 3168: LAUNCH_KERNEL(3168); break;
	case 3169: LAUNCH_KERNEL(3169); break;
	case 3170: LAUNCH_KERNEL(3170); break;
	case 3171: LAUNCH_KERNEL(3171); break;
	case 3172: LAUNCH_KERNEL(3172); break;
	case 3173: LAUNCH_KERNEL(3173); break;
	case 3174: LAUNCH_KERNEL(3174); break;
	case 3175: LAUNCH_KERNEL(3175); break;
	case 3176: LAUNCH_KERNEL(3176); break;
	case 3177: LAUNCH_KERNEL(3177); break;
	case 3178: LAUNCH_KERNEL(3178); break;
	case 3179: LAUNCH_KERNEL(3179); break;
	case 3180: LAUNCH_KERNEL(3180); break;
	case 3181: LAUNCH_KERNEL(3181); break;
	case 3182: LAUNCH_KERNEL(3182); break;
	case 3183: LAUNCH_KERNEL(3183); break;
	case 3184: LAUNCH_KERNEL(3184); break;
	case 3185: LAUNCH_KERNEL(3185); break;
	case 3186: LAUNCH_KERNEL(3186); break;
	case 3187: LAUNCH_KERNEL(3187); break;
	case 3188: LAUNCH_KERNEL(3188); break;
	case 3189: LAUNCH_KERNEL(3189); break;
	case 3190: LAUNCH_KERNEL(3190); break;
	case 3191: LAUNCH_KERNEL(3191); break;
	case 3192: LAUNCH_KERNEL(3192); break;
	case 3193: LAUNCH_KERNEL(3193); break;
	case 3194: LAUNCH_KERNEL(3194); break;
	case 3195: LAUNCH_KERNEL(3195); break;
	case 3196: LAUNCH_KERNEL(3196); break;
	case 3197: LAUNCH_KERNEL(3197); break;
	case 3198: LAUNCH_KERNEL(3198); break;
	case 3199: LAUNCH_KERNEL(3199); break;
	case 3200: LAUNCH_KERNEL(3200); break;
	case 3201: LAUNCH_KERNEL(3201); break;
	case 3202: LAUNCH_KERNEL(3202); break;
	case 3203: LAUNCH_KERNEL(3203); break;
	case 3204: LAUNCH_KERNEL(3204); break;
	case 3205: LAUNCH_KERNEL(3205); break;
	case 3206: LAUNCH_KERNEL(3206); break;
	case 3207: LAUNCH_KERNEL(3207); break;
	case 3208: LAUNCH_KERNEL(3208); break;
	case 3209: LAUNCH_KERNEL(3209); break;
	case 3210: LAUNCH_KERNEL(3210); break;
	case 3211: LAUNCH_KERNEL(3211); break;
	case 3212: LAUNCH_KERNEL(3212); break;
	case 3213: LAUNCH_KERNEL(3213); break;
	case 3214: LAUNCH_KERNEL(3214); break;
	case 3215: LAUNCH_KERNEL(3215); break;
	case 3216: LAUNCH_KERNEL(3216); break;
	case 3217: LAUNCH_KERNEL(3217); break;
	case 3218: LAUNCH_KERNEL(3218); break;
	case 3219: LAUNCH_KERNEL(3219); break;
	case 3220: LAUNCH_KERNEL(3220); break;
	case 3221: LAUNCH_KERNEL(3221); break;
	case 3222: LAUNCH_KERNEL(3222); break;
	case 3223: LAUNCH_KERNEL(3223); break;
	case 3224: LAUNCH_KERNEL(3224); break;
	case 3225: LAUNCH_KERNEL(3225); break;
	case 3226: LAUNCH_KERNEL(3226); break;
	case 3227: LAUNCH_KERNEL(3227); break;
	case 3228: LAUNCH_KERNEL(3228); break;
	case 3229: LAUNCH_KERNEL(3229); break;
	case 3230: LAUNCH_KERNEL(3230); break;
	case 3231: LAUNCH_KERNEL(3231); break;
	case 3232: LAUNCH_KERNEL(3232); break;
	case 3233: LAUNCH_KERNEL(3233); break;
	case 3234: LAUNCH_KERNEL(3234); break;
	case 3235: LAUNCH_KERNEL(3235); break;
	case 3236: LAUNCH_KERNEL(3236); break;
	case 3237: LAUNCH_KERNEL(3237); break;
	case 3238: LAUNCH_KERNEL(3238); break;
	case 3239: LAUNCH_KERNEL(3239); break;
	case 3240: LAUNCH_KERNEL(3240); break;
	case 3241: LAUNCH_KERNEL(3241); break;
	case 3242: LAUNCH_KERNEL(3242); break;
	case 3243: LAUNCH_KERNEL(3243); break;
	case 3244: LAUNCH_KERNEL(3244); break;
	case 3245: LAUNCH_KERNEL(3245); break;
	case 3246: LAUNCH_KERNEL(3246); break;
	case 3247: LAUNCH_KERNEL(3247); break;
	case 3248: LAUNCH_KERNEL(3248); break;
	case 3249: LAUNCH_KERNEL(3249); break;
	case 3250: LAUNCH_KERNEL(3250); break;
	case 3251: LAUNCH_KERNEL(3251); break;
	case 3252: LAUNCH_KERNEL(3252); break;
	case 3253: LAUNCH_KERNEL(3253); break;
	case 3254: LAUNCH_KERNEL(3254); break;
	case 3255: LAUNCH_KERNEL(3255); break;
	case 3256: LAUNCH_KERNEL(3256); break;
	case 3257: LAUNCH_KERNEL(3257); break;
	case 3258: LAUNCH_KERNEL(3258); break;
	case 3259: LAUNCH_KERNEL(3259); break;
	case 3260: LAUNCH_KERNEL(3260); break;
	case 3261: LAUNCH_KERNEL(3261); break;
	case 3262: LAUNCH_KERNEL(3262); break;
	case 3263: LAUNCH_KERNEL(3263); break;
	case 3264: LAUNCH_KERNEL(3264); break;
	case 3265: LAUNCH_KERNEL(3265); break;
	case 3266: LAUNCH_KERNEL(3266); break;
	case 3267: LAUNCH_KERNEL(3267); break;
	case 3268: LAUNCH_KERNEL(3268); break;
	case 3269: LAUNCH_KERNEL(3269); break;
	case 3270: LAUNCH_KERNEL(3270); break;
	case 3271: LAUNCH_KERNEL(3271); break;
	case 3272: LAUNCH_KERNEL(3272); break;
	case 3273: LAUNCH_KERNEL(3273); break;
	case 3274: LAUNCH_KERNEL(3274); break;
	case 3275: LAUNCH_KERNEL(3275); break;
	case 3276: LAUNCH_KERNEL(3276); break;
	case 3277: LAUNCH_KERNEL(3277); break;
	case 3278: LAUNCH_KERNEL(3278); break;
	case 3279: LAUNCH_KERNEL(3279); break;
	case 3280: LAUNCH_KERNEL(3280); break;
	case 3281: LAUNCH_KERNEL(3281); break;
	case 3282: LAUNCH_KERNEL(3282); break;
	case 3283: LAUNCH_KERNEL(3283); break;
	case 3284: LAUNCH_KERNEL(3284); break;
	case 3285: LAUNCH_KERNEL(3285); break;
	case 3286: LAUNCH_KERNEL(3286); break;
	case 3287: LAUNCH_KERNEL(3287); break;
	case 3288: LAUNCH_KERNEL(3288); break;
	case 3289: LAUNCH_KERNEL(3289); break;
	case 3290: LAUNCH_KERNEL(3290); break;
	case 3291: LAUNCH_KERNEL(3291); break;
	case 3292: LAUNCH_KERNEL(3292); break;
	case 3293: LAUNCH_KERNEL(3293); break;
	case 3294: LAUNCH_KERNEL(3294); break;
	case 3295: LAUNCH_KERNEL(3295); break;
	case 3296: LAUNCH_KERNEL(3296); break;
	case 3297: LAUNCH_KERNEL(3297); break;
	case 3298: LAUNCH_KERNEL(3298); break;
	case 3299: LAUNCH_KERNEL(3299); break;
	case 3300: LAUNCH_KERNEL(3300); break;
	case 3301: LAUNCH_KERNEL(3301); break;
	case 3302: LAUNCH_KERNEL(3302); break;
	case 3303: LAUNCH_KERNEL(3303); break;
	case 3304: LAUNCH_KERNEL(3304); break;
	case 3305: LAUNCH_KERNEL(3305); break;
	case 3306: LAUNCH_KERNEL(3306); break;
	case 3307: LAUNCH_KERNEL(3307); break;
	case 3308: LAUNCH_KERNEL(3308); break;
	case 3309: LAUNCH_KERNEL(3309); break;
	case 3310: LAUNCH_KERNEL(3310); break;
	case 3311: LAUNCH_KERNEL(3311); break;
	case 3312: LAUNCH_KERNEL(3312); break;
	case 3313: LAUNCH_KERNEL(3313); break;
	case 3314: LAUNCH_KERNEL(3314); break;
	case 3315: LAUNCH_KERNEL(3315); break;
	case 3316: LAUNCH_KERNEL(3316); break;
	case 3317: LAUNCH_KERNEL(3317); break;
	case 3318: LAUNCH_KERNEL(3318); break;
	case 3319: LAUNCH_KERNEL(3319); break;
	case 3320: LAUNCH_KERNEL(3320); break;
	case 3321: LAUNCH_KERNEL(3321); break;
	case 3322: LAUNCH_KERNEL(3322); break;
	case 3323: LAUNCH_KERNEL(3323); break;
	case 3324: LAUNCH_KERNEL(3324); break;
	case 3325: LAUNCH_KERNEL(3325); break;
	case 3326: LAUNCH_KERNEL(3326); break;
	case 3327: LAUNCH_KERNEL(3327); break;
	case 3328: LAUNCH_KERNEL(3328); break;
	case 3329: LAUNCH_KERNEL(3329); break;
	case 3330: LAUNCH_KERNEL(3330); break;
	case 3331: LAUNCH_KERNEL(3331); break;
	case 3332: LAUNCH_KERNEL(3332); break;
	case 3333: LAUNCH_KERNEL(3333); break;
	case 3334: LAUNCH_KERNEL(3334); break;
	case 3335: LAUNCH_KERNEL(3335); break;
	case 3336: LAUNCH_KERNEL(3336); break;
	case 3337: LAUNCH_KERNEL(3337); break;
	case 3338: LAUNCH_KERNEL(3338); break;
	case 3339: LAUNCH_KERNEL(3339); break;
	case 3340: LAUNCH_KERNEL(3340); break;
	case 3341: LAUNCH_KERNEL(3341); break;
	case 3342: LAUNCH_KERNEL(3342); break;
	case 3343: LAUNCH_KERNEL(3343); break;
	case 3344: LAUNCH_KERNEL(3344); break;
	case 3345: LAUNCH_KERNEL(3345); break;
	case 3346: LAUNCH_KERNEL(3346); break;
	case 3347: LAUNCH_KERNEL(3347); break;
	case 3348: LAUNCH_KERNEL(3348); break;
	case 3349: LAUNCH_KERNEL(3349); break;
	case 3350: LAUNCH_KERNEL(3350); break;
	case 3351: LAUNCH_KERNEL(3351); break;
	case 3352: LAUNCH_KERNEL(3352); break;
	case 3353: LAUNCH_KERNEL(3353); break;
	case 3354: LAUNCH_KERNEL(3354); break;
	case 3355: LAUNCH_KERNEL(3355); break;
	case 3356: LAUNCH_KERNEL(3356); break;
	case 3357: LAUNCH_KERNEL(3357); break;
	case 3358: LAUNCH_KERNEL(3358); break;
	case 3359: LAUNCH_KERNEL(3359); break;
	case 3360: LAUNCH_KERNEL(3360); break;
	case 3361: LAUNCH_KERNEL(3361); break;
	case 3362: LAUNCH_KERNEL(3362); break;
	case 3363: LAUNCH_KERNEL(3363); break;
	case 3364: LAUNCH_KERNEL(3364); break;
	case 3365: LAUNCH_KERNEL(3365); break;
	case 3366: LAUNCH_KERNEL(3366); break;
	case 3367: LAUNCH_KERNEL(3367); break;
	case 3368: LAUNCH_KERNEL(3368); break;
	case 3369: LAUNCH_KERNEL(3369); break;
	case 3370: LAUNCH_KERNEL(3370); break;
	case 3371: LAUNCH_KERNEL(3371); break;
	case 3372: LAUNCH_KERNEL(3372); break;
	case 3373: LAUNCH_KERNEL(3373); break;
	case 3374: LAUNCH_KERNEL(3374); break;
	case 3375: LAUNCH_KERNEL(3375); break;
	case 3376: LAUNCH_KERNEL(3376); break;
	case 3377: LAUNCH_KERNEL(3377); break;
	case 3378: LAUNCH_KERNEL(3378); break;
	case 3379: LAUNCH_KERNEL(3379); break;
	case 3380: LAUNCH_KERNEL(3380); break;
	case 3381: LAUNCH_KERNEL(3381); break;
	case 3382: LAUNCH_KERNEL(3382); break;
	case 3383: LAUNCH_KERNEL(3383); break;
	case 3384: LAUNCH_KERNEL(3384); break;
	case 3385: LAUNCH_KERNEL(3385); break;
	case 3386: LAUNCH_KERNEL(3386); break;
	case 3387: LAUNCH_KERNEL(3387); break;
	case 3388: LAUNCH_KERNEL(3388); break;
	case 3389: LAUNCH_KERNEL(3389); break;
	case 3390: LAUNCH_KERNEL(3390); break;
	case 3391: LAUNCH_KERNEL(3391); break;
	case 3392: LAUNCH_KERNEL(3392); break;
	case 3393: LAUNCH_KERNEL(3393); break;
	case 3394: LAUNCH_KERNEL(3394); break;
	case 3395: LAUNCH_KERNEL(3395); break;
	case 3396: LAUNCH_KERNEL(3396); break;
	case 3397: LAUNCH_KERNEL(3397); break;
	case 3398: LAUNCH_KERNEL(3398); break;
	case 3399: LAUNCH_KERNEL(3399); break;
	case 3400: LAUNCH_KERNEL(3400); break;
	case 3401: LAUNCH_KERNEL(3401); break;
	case 3402: LAUNCH_KERNEL(3402); break;
	case 3403: LAUNCH_KERNEL(3403); break;
	case 3404: LAUNCH_KERNEL(3404); break;
	case 3405: LAUNCH_KERNEL(3405); break;
	case 3406: LAUNCH_KERNEL(3406); break;
	case 3407: LAUNCH_KERNEL(3407); break;
	case 3408: LAUNCH_KERNEL(3408); break;
	case 3409: LAUNCH_KERNEL(3409); break;
	case 3410: LAUNCH_KERNEL(3410); break;
	case 3411: LAUNCH_KERNEL(3411); break;
	case 3412: LAUNCH_KERNEL(3412); break;
	case 3413: LAUNCH_KERNEL(3413); break;
	case 3414: LAUNCH_KERNEL(3414); break;
	case 3415: LAUNCH_KERNEL(3415); break;
	case 3416: LAUNCH_KERNEL(3416); break;
	case 3417: LAUNCH_KERNEL(3417); break;
	case 3418: LAUNCH_KERNEL(3418); break;
	case 3419: LAUNCH_KERNEL(3419); break;
	case 3420: LAUNCH_KERNEL(3420); break;
	case 3421: LAUNCH_KERNEL(3421); break;
	case 3422: LAUNCH_KERNEL(3422); break;
	case 3423: LAUNCH_KERNEL(3423); break;
	case 3424: LAUNCH_KERNEL(3424); break;
	case 3425: LAUNCH_KERNEL(3425); break;
	case 3426: LAUNCH_KERNEL(3426); break;
	case 3427: LAUNCH_KERNEL(3427); break;
	case 3428: LAUNCH_KERNEL(3428); break;
	case 3429: LAUNCH_KERNEL(3429); break;
	case 3430: LAUNCH_KERNEL(3430); break;
	case 3431: LAUNCH_KERNEL(3431); break;
	case 3432: LAUNCH_KERNEL(3432); break;
	case 3433: LAUNCH_KERNEL(3433); break;
	case 3434: LAUNCH_KERNEL(3434); break;
	case 3435: LAUNCH_KERNEL(3435); break;
	case 3436: LAUNCH_KERNEL(3436); break;
	case 3437: LAUNCH_KERNEL(3437); break;
	case 3438: LAUNCH_KERNEL(3438); break;
	case 3439: LAUNCH_KERNEL(3439); break;
	case 3440: LAUNCH_KERNEL(3440); break;
	case 3441: LAUNCH_KERNEL(3441); break;
	case 3442: LAUNCH_KERNEL(3442); break;
	case 3443: LAUNCH_KERNEL(3443); break;
	case 3444: LAUNCH_KERNEL(3444); break;
	case 3445: LAUNCH_KERNEL(3445); break;
	case 3446: LAUNCH_KERNEL(3446); break;
	case 3447: LAUNCH_KERNEL(3447); break;
	case 3448: LAUNCH_KERNEL(3448); break;
	case 3449: LAUNCH_KERNEL(3449); break;
	case 3450: LAUNCH_KERNEL(3450); break;
	case 3451: LAUNCH_KERNEL(3451); break;
	case 3452: LAUNCH_KERNEL(3452); break;
	case 3453: LAUNCH_KERNEL(3453); break;
	case 3454: LAUNCH_KERNEL(3454); break;
	case 3455: LAUNCH_KERNEL(3455); break;
	case 3456: LAUNCH_KERNEL(3456); break;
	case 3457: LAUNCH_KERNEL(3457); break;
	case 3458: LAUNCH_KERNEL(3458); break;
	case 3459: LAUNCH_KERNEL(3459); break;
	case 3460: LAUNCH_KERNEL(3460); break;
	case 3461: LAUNCH_KERNEL(3461); break;
	case 3462: LAUNCH_KERNEL(3462); break;
	case 3463: LAUNCH_KERNEL(3463); break;
	case 3464: LAUNCH_KERNEL(3464); break;
	case 3465: LAUNCH_KERNEL(3465); break;
	case 3466: LAUNCH_KERNEL(3466); break;
	case 3467: LAUNCH_KERNEL(3467); break;
	case 3468: LAUNCH_KERNEL(3468); break;
	case 3469: LAUNCH_KERNEL(3469); break;
	case 3470: LAUNCH_KERNEL(3470); break;
	case 3471: LAUNCH_KERNEL(3471); break;
	case 3472: LAUNCH_KERNEL(3472); break;
	case 3473: LAUNCH_KERNEL(3473); break;
	case 3474: LAUNCH_KERNEL(3474); break;
	case 3475: LAUNCH_KERNEL(3475); break;
	case 3476: LAUNCH_KERNEL(3476); break;
	case 3477: LAUNCH_KERNEL(3477); break;
	case 3478: LAUNCH_KERNEL(3478); break;
	case 3479: LAUNCH_KERNEL(3479); break;
	case 3480: LAUNCH_KERNEL(3480); break;
	case 3481: LAUNCH_KERNEL(3481); break;
	case 3482: LAUNCH_KERNEL(3482); break;
	case 3483: LAUNCH_KERNEL(3483); break;
	case 3484: LAUNCH_KERNEL(3484); break;
	case 3485: LAUNCH_KERNEL(3485); break;
	case 3486: LAUNCH_KERNEL(3486); break;
	case 3487: LAUNCH_KERNEL(3487); break;
	case 3488: LAUNCH_KERNEL(3488); break;
	case 3489: LAUNCH_KERNEL(3489); break;
	case 3490: LAUNCH_KERNEL(3490); break;
	case 3491: LAUNCH_KERNEL(3491); break;
	case 3492: LAUNCH_KERNEL(3492); break;
	case 3493: LAUNCH_KERNEL(3493); break;
	case 3494: LAUNCH_KERNEL(3494); break;
	case 3495: LAUNCH_KERNEL(3495); break;
	case 3496: LAUNCH_KERNEL(3496); break;
	case 3497: LAUNCH_KERNEL(3497); break;
	case 3498: LAUNCH_KERNEL(3498); break;
	case 3499: LAUNCH_KERNEL(3499); break;
	case 3500: LAUNCH_KERNEL(3500); break;
	case 3501: LAUNCH_KERNEL(3501); break;
	case 3502: LAUNCH_KERNEL(3502); break;
	case 3503: LAUNCH_KERNEL(3503); break;
	case 3504: LAUNCH_KERNEL(3504); break;
	case 3505: LAUNCH_KERNEL(3505); break;
	case 3506: LAUNCH_KERNEL(3506); break;
	case 3507: LAUNCH_KERNEL(3507); break;
	case 3508: LAUNCH_KERNEL(3508); break;
	case 3509: LAUNCH_KERNEL(3509); break;
	case 3510: LAUNCH_KERNEL(3510); break;
	case 3511: LAUNCH_KERNEL(3511); break;
	case 3512: LAUNCH_KERNEL(3512); break;
	case 3513: LAUNCH_KERNEL(3513); break;
	case 3514: LAUNCH_KERNEL(3514); break;
	case 3515: LAUNCH_KERNEL(3515); break;
	case 3516: LAUNCH_KERNEL(3516); break;
	case 3517: LAUNCH_KERNEL(3517); break;
	case 3518: LAUNCH_KERNEL(3518); break;
	case 3519: LAUNCH_KERNEL(3519); break;
	case 3520: LAUNCH_KERNEL(3520); break;
	case 3521: LAUNCH_KERNEL(3521); break;
	case 3522: LAUNCH_KERNEL(3522); break;
	case 3523: LAUNCH_KERNEL(3523); break;
	case 3524: LAUNCH_KERNEL(3524); break;
	case 3525: LAUNCH_KERNEL(3525); break;
	case 3526: LAUNCH_KERNEL(3526); break;
	case 3527: LAUNCH_KERNEL(3527); break;
	case 3528: LAUNCH_KERNEL(3528); break;
	case 3529: LAUNCH_KERNEL(3529); break;
	case 3530: LAUNCH_KERNEL(3530); break;
	case 3531: LAUNCH_KERNEL(3531); break;
	case 3532: LAUNCH_KERNEL(3532); break;
	case 3533: LAUNCH_KERNEL(3533); break;
	case 3534: LAUNCH_KERNEL(3534); break;
	case 3535: LAUNCH_KERNEL(3535); break;
	case 3536: LAUNCH_KERNEL(3536); break;
	case 3537: LAUNCH_KERNEL(3537); break;
	case 3538: LAUNCH_KERNEL(3538); break;
	case 3539: LAUNCH_KERNEL(3539); break;
	case 3540: LAUNCH_KERNEL(3540); break;
	case 3541: LAUNCH_KERNEL(3541); break;
	case 3542: LAUNCH_KERNEL(3542); break;
	case 3543: LAUNCH_KERNEL(3543); break;
	case 3544: LAUNCH_KERNEL(3544); break;
	case 3545: LAUNCH_KERNEL(3545); break;
	case 3546: LAUNCH_KERNEL(3546); break;
	case 3547: LAUNCH_KERNEL(3547); break;
	case 3548: LAUNCH_KERNEL(3548); break;
	case 3549: LAUNCH_KERNEL(3549); break;
	case 3550: LAUNCH_KERNEL(3550); break;
	case 3551: LAUNCH_KERNEL(3551); break;
	case 3552: LAUNCH_KERNEL(3552); break;
	case 3553: LAUNCH_KERNEL(3553); break;
	case 3554: LAUNCH_KERNEL(3554); break;
	case 3555: LAUNCH_KERNEL(3555); break;
	case 3556: LAUNCH_KERNEL(3556); break;
	case 3557: LAUNCH_KERNEL(3557); break;
	case 3558: LAUNCH_KERNEL(3558); break;
	case 3559: LAUNCH_KERNEL(3559); break;
	case 3560: LAUNCH_KERNEL(3560); break;
	case 3561: LAUNCH_KERNEL(3561); break;
	case 3562: LAUNCH_KERNEL(3562); break;
	case 3563: LAUNCH_KERNEL(3563); break;
	case 3564: LAUNCH_KERNEL(3564); break;
	case 3565: LAUNCH_KERNEL(3565); break;
	case 3566: LAUNCH_KERNEL(3566); break;
	case 3567: LAUNCH_KERNEL(3567); break;
	case 3568: LAUNCH_KERNEL(3568); break;
	case 3569: LAUNCH_KERNEL(3569); break;
	case 3570: LAUNCH_KERNEL(3570); break;
	case 3571: LAUNCH_KERNEL(3571); break;
	case 3572: LAUNCH_KERNEL(3572); break;
	case 3573: LAUNCH_KERNEL(3573); break;
	case 3574: LAUNCH_KERNEL(3574); break;
	case 3575: LAUNCH_KERNEL(3575); break;
	case 3576: LAUNCH_KERNEL(3576); break;
	case 3577: LAUNCH_KERNEL(3577); break;
	case 3578: LAUNCH_KERNEL(3578); break;
	case 3579: LAUNCH_KERNEL(3579); break;
	case 3580: LAUNCH_KERNEL(3580); break;
	case 3581: LAUNCH_KERNEL(3581); break;
	case 3582: LAUNCH_KERNEL(3582); break;
	case 3583: LAUNCH_KERNEL(3583); break;
	default: printf("intSalt: %d\n", intSalt); ASSERT(FALSE);
	}
}

#endif
