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

#define SALT 512
#include "CUDA10_Registers_Kernel.h"
#define SALT 513
#include "CUDA10_Registers_Kernel.h"
#define SALT 514
#include "CUDA10_Registers_Kernel.h"
#define SALT 515
#include "CUDA10_Registers_Kernel.h"
#define SALT 516
#include "CUDA10_Registers_Kernel.h"
#define SALT 517
#include "CUDA10_Registers_Kernel.h"
#define SALT 518
#include "CUDA10_Registers_Kernel.h"
#define SALT 519
#include "CUDA10_Registers_Kernel.h"
#define SALT 520
#include "CUDA10_Registers_Kernel.h"
#define SALT 521
#include "CUDA10_Registers_Kernel.h"
#define SALT 522
#include "CUDA10_Registers_Kernel.h"
#define SALT 523
#include "CUDA10_Registers_Kernel.h"
#define SALT 524
#include "CUDA10_Registers_Kernel.h"
#define SALT 525
#include "CUDA10_Registers_Kernel.h"
#define SALT 526
#include "CUDA10_Registers_Kernel.h"
#define SALT 527
#include "CUDA10_Registers_Kernel.h"
#define SALT 528
#include "CUDA10_Registers_Kernel.h"
#define SALT 529
#include "CUDA10_Registers_Kernel.h"
#define SALT 530
#include "CUDA10_Registers_Kernel.h"
#define SALT 531
#include "CUDA10_Registers_Kernel.h"
#define SALT 532
#include "CUDA10_Registers_Kernel.h"
#define SALT 533
#include "CUDA10_Registers_Kernel.h"
#define SALT 534
#include "CUDA10_Registers_Kernel.h"
#define SALT 535
#include "CUDA10_Registers_Kernel.h"
#define SALT 536
#include "CUDA10_Registers_Kernel.h"
#define SALT 537
#include "CUDA10_Registers_Kernel.h"
#define SALT 538
#include "CUDA10_Registers_Kernel.h"
#define SALT 539
#include "CUDA10_Registers_Kernel.h"
#define SALT 540
#include "CUDA10_Registers_Kernel.h"
#define SALT 541
#include "CUDA10_Registers_Kernel.h"
#define SALT 542
#include "CUDA10_Registers_Kernel.h"
#define SALT 543
#include "CUDA10_Registers_Kernel.h"
#define SALT 544
#include "CUDA10_Registers_Kernel.h"
#define SALT 545
#include "CUDA10_Registers_Kernel.h"
#define SALT 546
#include "CUDA10_Registers_Kernel.h"
#define SALT 547
#include "CUDA10_Registers_Kernel.h"
#define SALT 548
#include "CUDA10_Registers_Kernel.h"
#define SALT 549
#include "CUDA10_Registers_Kernel.h"
#define SALT 550
#include "CUDA10_Registers_Kernel.h"
#define SALT 551
#include "CUDA10_Registers_Kernel.h"
#define SALT 552
#include "CUDA10_Registers_Kernel.h"
#define SALT 553
#include "CUDA10_Registers_Kernel.h"
#define SALT 554
#include "CUDA10_Registers_Kernel.h"
#define SALT 555
#include "CUDA10_Registers_Kernel.h"
#define SALT 556
#include "CUDA10_Registers_Kernel.h"
#define SALT 557
#include "CUDA10_Registers_Kernel.h"
#define SALT 558
#include "CUDA10_Registers_Kernel.h"
#define SALT 559
#include "CUDA10_Registers_Kernel.h"
#define SALT 560
#include "CUDA10_Registers_Kernel.h"
#define SALT 561
#include "CUDA10_Registers_Kernel.h"
#define SALT 562
#include "CUDA10_Registers_Kernel.h"
#define SALT 563
#include "CUDA10_Registers_Kernel.h"
#define SALT 564
#include "CUDA10_Registers_Kernel.h"
#define SALT 565
#include "CUDA10_Registers_Kernel.h"
#define SALT 566
#include "CUDA10_Registers_Kernel.h"
#define SALT 567
#include "CUDA10_Registers_Kernel.h"
#define SALT 568
#include "CUDA10_Registers_Kernel.h"
#define SALT 569
#include "CUDA10_Registers_Kernel.h"
#define SALT 570
#include "CUDA10_Registers_Kernel.h"
#define SALT 571
#include "CUDA10_Registers_Kernel.h"
#define SALT 572
#include "CUDA10_Registers_Kernel.h"
#define SALT 573
#include "CUDA10_Registers_Kernel.h"
#define SALT 574
#include "CUDA10_Registers_Kernel.h"
#define SALT 575
#include "CUDA10_Registers_Kernel.h"
#define SALT 576
#include "CUDA10_Registers_Kernel.h"
#define SALT 577
#include "CUDA10_Registers_Kernel.h"
#define SALT 578
#include "CUDA10_Registers_Kernel.h"
#define SALT 579
#include "CUDA10_Registers_Kernel.h"
#define SALT 580
#include "CUDA10_Registers_Kernel.h"
#define SALT 581
#include "CUDA10_Registers_Kernel.h"
#define SALT 582
#include "CUDA10_Registers_Kernel.h"
#define SALT 583
#include "CUDA10_Registers_Kernel.h"
#define SALT 584
#include "CUDA10_Registers_Kernel.h"
#define SALT 585
#include "CUDA10_Registers_Kernel.h"
#define SALT 586
#include "CUDA10_Registers_Kernel.h"
#define SALT 587
#include "CUDA10_Registers_Kernel.h"
#define SALT 588
#include "CUDA10_Registers_Kernel.h"
#define SALT 589
#include "CUDA10_Registers_Kernel.h"
#define SALT 590
#include "CUDA10_Registers_Kernel.h"
#define SALT 591
#include "CUDA10_Registers_Kernel.h"
#define SALT 592
#include "CUDA10_Registers_Kernel.h"
#define SALT 593
#include "CUDA10_Registers_Kernel.h"
#define SALT 594
#include "CUDA10_Registers_Kernel.h"
#define SALT 595
#include "CUDA10_Registers_Kernel.h"
#define SALT 596
#include "CUDA10_Registers_Kernel.h"
#define SALT 597
#include "CUDA10_Registers_Kernel.h"
#define SALT 598
#include "CUDA10_Registers_Kernel.h"
#define SALT 599
#include "CUDA10_Registers_Kernel.h"
#define SALT 600
#include "CUDA10_Registers_Kernel.h"
#define SALT 601
#include "CUDA10_Registers_Kernel.h"
#define SALT 602
#include "CUDA10_Registers_Kernel.h"
#define SALT 603
#include "CUDA10_Registers_Kernel.h"
#define SALT 604
#include "CUDA10_Registers_Kernel.h"
#define SALT 605
#include "CUDA10_Registers_Kernel.h"
#define SALT 606
#include "CUDA10_Registers_Kernel.h"
#define SALT 607
#include "CUDA10_Registers_Kernel.h"
#define SALT 608
#include "CUDA10_Registers_Kernel.h"
#define SALT 609
#include "CUDA10_Registers_Kernel.h"
#define SALT 610
#include "CUDA10_Registers_Kernel.h"
#define SALT 611
#include "CUDA10_Registers_Kernel.h"
#define SALT 612
#include "CUDA10_Registers_Kernel.h"
#define SALT 613
#include "CUDA10_Registers_Kernel.h"
#define SALT 614
#include "CUDA10_Registers_Kernel.h"
#define SALT 615
#include "CUDA10_Registers_Kernel.h"
#define SALT 616
#include "CUDA10_Registers_Kernel.h"
#define SALT 617
#include "CUDA10_Registers_Kernel.h"
#define SALT 618
#include "CUDA10_Registers_Kernel.h"
#define SALT 619
#include "CUDA10_Registers_Kernel.h"
#define SALT 620
#include "CUDA10_Registers_Kernel.h"
#define SALT 621
#include "CUDA10_Registers_Kernel.h"
#define SALT 622
#include "CUDA10_Registers_Kernel.h"
#define SALT 623
#include "CUDA10_Registers_Kernel.h"
#define SALT 624
#include "CUDA10_Registers_Kernel.h"
#define SALT 625
#include "CUDA10_Registers_Kernel.h"
#define SALT 626
#include "CUDA10_Registers_Kernel.h"
#define SALT 627
#include "CUDA10_Registers_Kernel.h"
#define SALT 628
#include "CUDA10_Registers_Kernel.h"
#define SALT 629
#include "CUDA10_Registers_Kernel.h"
#define SALT 630
#include "CUDA10_Registers_Kernel.h"
#define SALT 631
#include "CUDA10_Registers_Kernel.h"
#define SALT 632
#include "CUDA10_Registers_Kernel.h"
#define SALT 633
#include "CUDA10_Registers_Kernel.h"
#define SALT 634
#include "CUDA10_Registers_Kernel.h"
#define SALT 635
#include "CUDA10_Registers_Kernel.h"
#define SALT 636
#include "CUDA10_Registers_Kernel.h"
#define SALT 637
#include "CUDA10_Registers_Kernel.h"
#define SALT 638
#include "CUDA10_Registers_Kernel.h"
#define SALT 639
#include "CUDA10_Registers_Kernel.h"
#define SALT 640
#include "CUDA10_Registers_Kernel.h"
#define SALT 641
#include "CUDA10_Registers_Kernel.h"
#define SALT 642
#include "CUDA10_Registers_Kernel.h"
#define SALT 643
#include "CUDA10_Registers_Kernel.h"
#define SALT 644
#include "CUDA10_Registers_Kernel.h"
#define SALT 645
#include "CUDA10_Registers_Kernel.h"
#define SALT 646
#include "CUDA10_Registers_Kernel.h"
#define SALT 647
#include "CUDA10_Registers_Kernel.h"
#define SALT 648
#include "CUDA10_Registers_Kernel.h"
#define SALT 649
#include "CUDA10_Registers_Kernel.h"
#define SALT 650
#include "CUDA10_Registers_Kernel.h"
#define SALT 651
#include "CUDA10_Registers_Kernel.h"
#define SALT 652
#include "CUDA10_Registers_Kernel.h"
#define SALT 653
#include "CUDA10_Registers_Kernel.h"
#define SALT 654
#include "CUDA10_Registers_Kernel.h"
#define SALT 655
#include "CUDA10_Registers_Kernel.h"
#define SALT 656
#include "CUDA10_Registers_Kernel.h"
#define SALT 657
#include "CUDA10_Registers_Kernel.h"
#define SALT 658
#include "CUDA10_Registers_Kernel.h"
#define SALT 659
#include "CUDA10_Registers_Kernel.h"
#define SALT 660
#include "CUDA10_Registers_Kernel.h"
#define SALT 661
#include "CUDA10_Registers_Kernel.h"
#define SALT 662
#include "CUDA10_Registers_Kernel.h"
#define SALT 663
#include "CUDA10_Registers_Kernel.h"
#define SALT 664
#include "CUDA10_Registers_Kernel.h"
#define SALT 665
#include "CUDA10_Registers_Kernel.h"
#define SALT 666
#include "CUDA10_Registers_Kernel.h"
#define SALT 667
#include "CUDA10_Registers_Kernel.h"
#define SALT 668
#include "CUDA10_Registers_Kernel.h"
#define SALT 669
#include "CUDA10_Registers_Kernel.h"
#define SALT 670
#include "CUDA10_Registers_Kernel.h"
#define SALT 671
#include "CUDA10_Registers_Kernel.h"
#define SALT 672
#include "CUDA10_Registers_Kernel.h"
#define SALT 673
#include "CUDA10_Registers_Kernel.h"
#define SALT 674
#include "CUDA10_Registers_Kernel.h"
#define SALT 675
#include "CUDA10_Registers_Kernel.h"
#define SALT 676
#include "CUDA10_Registers_Kernel.h"
#define SALT 677
#include "CUDA10_Registers_Kernel.h"
#define SALT 678
#include "CUDA10_Registers_Kernel.h"
#define SALT 679
#include "CUDA10_Registers_Kernel.h"
#define SALT 680
#include "CUDA10_Registers_Kernel.h"
#define SALT 681
#include "CUDA10_Registers_Kernel.h"
#define SALT 682
#include "CUDA10_Registers_Kernel.h"
#define SALT 683
#include "CUDA10_Registers_Kernel.h"
#define SALT 684
#include "CUDA10_Registers_Kernel.h"
#define SALT 685
#include "CUDA10_Registers_Kernel.h"
#define SALT 686
#include "CUDA10_Registers_Kernel.h"
#define SALT 687
#include "CUDA10_Registers_Kernel.h"
#define SALT 688
#include "CUDA10_Registers_Kernel.h"
#define SALT 689
#include "CUDA10_Registers_Kernel.h"
#define SALT 690
#include "CUDA10_Registers_Kernel.h"
#define SALT 691
#include "CUDA10_Registers_Kernel.h"
#define SALT 692
#include "CUDA10_Registers_Kernel.h"
#define SALT 693
#include "CUDA10_Registers_Kernel.h"
#define SALT 694
#include "CUDA10_Registers_Kernel.h"
#define SALT 695
#include "CUDA10_Registers_Kernel.h"
#define SALT 696
#include "CUDA10_Registers_Kernel.h"
#define SALT 697
#include "CUDA10_Registers_Kernel.h"
#define SALT 698
#include "CUDA10_Registers_Kernel.h"
#define SALT 699
#include "CUDA10_Registers_Kernel.h"
#define SALT 700
#include "CUDA10_Registers_Kernel.h"
#define SALT 701
#include "CUDA10_Registers_Kernel.h"
#define SALT 702
#include "CUDA10_Registers_Kernel.h"
#define SALT 703
#include "CUDA10_Registers_Kernel.h"
#define SALT 704
#include "CUDA10_Registers_Kernel.h"
#define SALT 705
#include "CUDA10_Registers_Kernel.h"
#define SALT 706
#include "CUDA10_Registers_Kernel.h"
#define SALT 707
#include "CUDA10_Registers_Kernel.h"
#define SALT 708
#include "CUDA10_Registers_Kernel.h"
#define SALT 709
#include "CUDA10_Registers_Kernel.h"
#define SALT 710
#include "CUDA10_Registers_Kernel.h"
#define SALT 711
#include "CUDA10_Registers_Kernel.h"
#define SALT 712
#include "CUDA10_Registers_Kernel.h"
#define SALT 713
#include "CUDA10_Registers_Kernel.h"
#define SALT 714
#include "CUDA10_Registers_Kernel.h"
#define SALT 715
#include "CUDA10_Registers_Kernel.h"
#define SALT 716
#include "CUDA10_Registers_Kernel.h"
#define SALT 717
#include "CUDA10_Registers_Kernel.h"
#define SALT 718
#include "CUDA10_Registers_Kernel.h"
#define SALT 719
#include "CUDA10_Registers_Kernel.h"
#define SALT 720
#include "CUDA10_Registers_Kernel.h"
#define SALT 721
#include "CUDA10_Registers_Kernel.h"
#define SALT 722
#include "CUDA10_Registers_Kernel.h"
#define SALT 723
#include "CUDA10_Registers_Kernel.h"
#define SALT 724
#include "CUDA10_Registers_Kernel.h"
#define SALT 725
#include "CUDA10_Registers_Kernel.h"
#define SALT 726
#include "CUDA10_Registers_Kernel.h"
#define SALT 727
#include "CUDA10_Registers_Kernel.h"
#define SALT 728
#include "CUDA10_Registers_Kernel.h"
#define SALT 729
#include "CUDA10_Registers_Kernel.h"
#define SALT 730
#include "CUDA10_Registers_Kernel.h"
#define SALT 731
#include "CUDA10_Registers_Kernel.h"
#define SALT 732
#include "CUDA10_Registers_Kernel.h"
#define SALT 733
#include "CUDA10_Registers_Kernel.h"
#define SALT 734
#include "CUDA10_Registers_Kernel.h"
#define SALT 735
#include "CUDA10_Registers_Kernel.h"
#define SALT 736
#include "CUDA10_Registers_Kernel.h"
#define SALT 737
#include "CUDA10_Registers_Kernel.h"
#define SALT 738
#include "CUDA10_Registers_Kernel.h"
#define SALT 739
#include "CUDA10_Registers_Kernel.h"
#define SALT 740
#include "CUDA10_Registers_Kernel.h"
#define SALT 741
#include "CUDA10_Registers_Kernel.h"
#define SALT 742
#include "CUDA10_Registers_Kernel.h"
#define SALT 743
#include "CUDA10_Registers_Kernel.h"
#define SALT 744
#include "CUDA10_Registers_Kernel.h"
#define SALT 745
#include "CUDA10_Registers_Kernel.h"
#define SALT 746
#include "CUDA10_Registers_Kernel.h"
#define SALT 747
#include "CUDA10_Registers_Kernel.h"
#define SALT 748
#include "CUDA10_Registers_Kernel.h"
#define SALT 749
#include "CUDA10_Registers_Kernel.h"
#define SALT 750
#include "CUDA10_Registers_Kernel.h"
#define SALT 751
#include "CUDA10_Registers_Kernel.h"
#define SALT 752
#include "CUDA10_Registers_Kernel.h"
#define SALT 753
#include "CUDA10_Registers_Kernel.h"
#define SALT 754
#include "CUDA10_Registers_Kernel.h"
#define SALT 755
#include "CUDA10_Registers_Kernel.h"
#define SALT 756
#include "CUDA10_Registers_Kernel.h"
#define SALT 757
#include "CUDA10_Registers_Kernel.h"
#define SALT 758
#include "CUDA10_Registers_Kernel.h"
#define SALT 759
#include "CUDA10_Registers_Kernel.h"
#define SALT 760
#include "CUDA10_Registers_Kernel.h"
#define SALT 761
#include "CUDA10_Registers_Kernel.h"
#define SALT 762
#include "CUDA10_Registers_Kernel.h"
#define SALT 763
#include "CUDA10_Registers_Kernel.h"
#define SALT 764
#include "CUDA10_Registers_Kernel.h"
#define SALT 765
#include "CUDA10_Registers_Kernel.h"
#define SALT 766
#include "CUDA10_Registers_Kernel.h"
#define SALT 767
#include "CUDA10_Registers_Kernel.h"
#define SALT 768
#include "CUDA10_Registers_Kernel.h"
#define SALT 769
#include "CUDA10_Registers_Kernel.h"
#define SALT 770
#include "CUDA10_Registers_Kernel.h"
#define SALT 771
#include "CUDA10_Registers_Kernel.h"
#define SALT 772
#include "CUDA10_Registers_Kernel.h"
#define SALT 773
#include "CUDA10_Registers_Kernel.h"
#define SALT 774
#include "CUDA10_Registers_Kernel.h"
#define SALT 775
#include "CUDA10_Registers_Kernel.h"
#define SALT 776
#include "CUDA10_Registers_Kernel.h"
#define SALT 777
#include "CUDA10_Registers_Kernel.h"
#define SALT 778
#include "CUDA10_Registers_Kernel.h"
#define SALT 779
#include "CUDA10_Registers_Kernel.h"
#define SALT 780
#include "CUDA10_Registers_Kernel.h"
#define SALT 781
#include "CUDA10_Registers_Kernel.h"
#define SALT 782
#include "CUDA10_Registers_Kernel.h"
#define SALT 783
#include "CUDA10_Registers_Kernel.h"
#define SALT 784
#include "CUDA10_Registers_Kernel.h"
#define SALT 785
#include "CUDA10_Registers_Kernel.h"
#define SALT 786
#include "CUDA10_Registers_Kernel.h"
#define SALT 787
#include "CUDA10_Registers_Kernel.h"
#define SALT 788
#include "CUDA10_Registers_Kernel.h"
#define SALT 789
#include "CUDA10_Registers_Kernel.h"
#define SALT 790
#include "CUDA10_Registers_Kernel.h"
#define SALT 791
#include "CUDA10_Registers_Kernel.h"
#define SALT 792
#include "CUDA10_Registers_Kernel.h"
#define SALT 793
#include "CUDA10_Registers_Kernel.h"
#define SALT 794
#include "CUDA10_Registers_Kernel.h"
#define SALT 795
#include "CUDA10_Registers_Kernel.h"
#define SALT 796
#include "CUDA10_Registers_Kernel.h"
#define SALT 797
#include "CUDA10_Registers_Kernel.h"
#define SALT 798
#include "CUDA10_Registers_Kernel.h"
#define SALT 799
#include "CUDA10_Registers_Kernel.h"
#define SALT 800
#include "CUDA10_Registers_Kernel.h"
#define SALT 801
#include "CUDA10_Registers_Kernel.h"
#define SALT 802
#include "CUDA10_Registers_Kernel.h"
#define SALT 803
#include "CUDA10_Registers_Kernel.h"
#define SALT 804
#include "CUDA10_Registers_Kernel.h"
#define SALT 805
#include "CUDA10_Registers_Kernel.h"
#define SALT 806
#include "CUDA10_Registers_Kernel.h"
#define SALT 807
#include "CUDA10_Registers_Kernel.h"
#define SALT 808
#include "CUDA10_Registers_Kernel.h"
#define SALT 809
#include "CUDA10_Registers_Kernel.h"
#define SALT 810
#include "CUDA10_Registers_Kernel.h"
#define SALT 811
#include "CUDA10_Registers_Kernel.h"
#define SALT 812
#include "CUDA10_Registers_Kernel.h"
#define SALT 813
#include "CUDA10_Registers_Kernel.h"
#define SALT 814
#include "CUDA10_Registers_Kernel.h"
#define SALT 815
#include "CUDA10_Registers_Kernel.h"
#define SALT 816
#include "CUDA10_Registers_Kernel.h"
#define SALT 817
#include "CUDA10_Registers_Kernel.h"
#define SALT 818
#include "CUDA10_Registers_Kernel.h"
#define SALT 819
#include "CUDA10_Registers_Kernel.h"
#define SALT 820
#include "CUDA10_Registers_Kernel.h"
#define SALT 821
#include "CUDA10_Registers_Kernel.h"
#define SALT 822
#include "CUDA10_Registers_Kernel.h"
#define SALT 823
#include "CUDA10_Registers_Kernel.h"
#define SALT 824
#include "CUDA10_Registers_Kernel.h"
#define SALT 825
#include "CUDA10_Registers_Kernel.h"
#define SALT 826
#include "CUDA10_Registers_Kernel.h"
#define SALT 827
#include "CUDA10_Registers_Kernel.h"
#define SALT 828
#include "CUDA10_Registers_Kernel.h"
#define SALT 829
#include "CUDA10_Registers_Kernel.h"
#define SALT 830
#include "CUDA10_Registers_Kernel.h"
#define SALT 831
#include "CUDA10_Registers_Kernel.h"
#define SALT 832
#include "CUDA10_Registers_Kernel.h"
#define SALT 833
#include "CUDA10_Registers_Kernel.h"
#define SALT 834
#include "CUDA10_Registers_Kernel.h"
#define SALT 835
#include "CUDA10_Registers_Kernel.h"
#define SALT 836
#include "CUDA10_Registers_Kernel.h"
#define SALT 837
#include "CUDA10_Registers_Kernel.h"
#define SALT 838
#include "CUDA10_Registers_Kernel.h"
#define SALT 839
#include "CUDA10_Registers_Kernel.h"
#define SALT 840
#include "CUDA10_Registers_Kernel.h"
#define SALT 841
#include "CUDA10_Registers_Kernel.h"
#define SALT 842
#include "CUDA10_Registers_Kernel.h"
#define SALT 843
#include "CUDA10_Registers_Kernel.h"
#define SALT 844
#include "CUDA10_Registers_Kernel.h"
#define SALT 845
#include "CUDA10_Registers_Kernel.h"
#define SALT 846
#include "CUDA10_Registers_Kernel.h"
#define SALT 847
#include "CUDA10_Registers_Kernel.h"
#define SALT 848
#include "CUDA10_Registers_Kernel.h"
#define SALT 849
#include "CUDA10_Registers_Kernel.h"
#define SALT 850
#include "CUDA10_Registers_Kernel.h"
#define SALT 851
#include "CUDA10_Registers_Kernel.h"
#define SALT 852
#include "CUDA10_Registers_Kernel.h"
#define SALT 853
#include "CUDA10_Registers_Kernel.h"
#define SALT 854
#include "CUDA10_Registers_Kernel.h"
#define SALT 855
#include "CUDA10_Registers_Kernel.h"
#define SALT 856
#include "CUDA10_Registers_Kernel.h"
#define SALT 857
#include "CUDA10_Registers_Kernel.h"
#define SALT 858
#include "CUDA10_Registers_Kernel.h"
#define SALT 859
#include "CUDA10_Registers_Kernel.h"
#define SALT 860
#include "CUDA10_Registers_Kernel.h"
#define SALT 861
#include "CUDA10_Registers_Kernel.h"
#define SALT 862
#include "CUDA10_Registers_Kernel.h"
#define SALT 863
#include "CUDA10_Registers_Kernel.h"
#define SALT 864
#include "CUDA10_Registers_Kernel.h"
#define SALT 865
#include "CUDA10_Registers_Kernel.h"
#define SALT 866
#include "CUDA10_Registers_Kernel.h"
#define SALT 867
#include "CUDA10_Registers_Kernel.h"
#define SALT 868
#include "CUDA10_Registers_Kernel.h"
#define SALT 869
#include "CUDA10_Registers_Kernel.h"
#define SALT 870
#include "CUDA10_Registers_Kernel.h"
#define SALT 871
#include "CUDA10_Registers_Kernel.h"
#define SALT 872
#include "CUDA10_Registers_Kernel.h"
#define SALT 873
#include "CUDA10_Registers_Kernel.h"
#define SALT 874
#include "CUDA10_Registers_Kernel.h"
#define SALT 875
#include "CUDA10_Registers_Kernel.h"
#define SALT 876
#include "CUDA10_Registers_Kernel.h"
#define SALT 877
#include "CUDA10_Registers_Kernel.h"
#define SALT 878
#include "CUDA10_Registers_Kernel.h"
#define SALT 879
#include "CUDA10_Registers_Kernel.h"
#define SALT 880
#include "CUDA10_Registers_Kernel.h"
#define SALT 881
#include "CUDA10_Registers_Kernel.h"
#define SALT 882
#include "CUDA10_Registers_Kernel.h"
#define SALT 883
#include "CUDA10_Registers_Kernel.h"
#define SALT 884
#include "CUDA10_Registers_Kernel.h"
#define SALT 885
#include "CUDA10_Registers_Kernel.h"
#define SALT 886
#include "CUDA10_Registers_Kernel.h"
#define SALT 887
#include "CUDA10_Registers_Kernel.h"
#define SALT 888
#include "CUDA10_Registers_Kernel.h"
#define SALT 889
#include "CUDA10_Registers_Kernel.h"
#define SALT 890
#include "CUDA10_Registers_Kernel.h"
#define SALT 891
#include "CUDA10_Registers_Kernel.h"
#define SALT 892
#include "CUDA10_Registers_Kernel.h"
#define SALT 893
#include "CUDA10_Registers_Kernel.h"
#define SALT 894
#include "CUDA10_Registers_Kernel.h"
#define SALT 895
#include "CUDA10_Registers_Kernel.h"
#define SALT 896
#include "CUDA10_Registers_Kernel.h"
#define SALT 897
#include "CUDA10_Registers_Kernel.h"
#define SALT 898
#include "CUDA10_Registers_Kernel.h"
#define SALT 899
#include "CUDA10_Registers_Kernel.h"
#define SALT 900
#include "CUDA10_Registers_Kernel.h"
#define SALT 901
#include "CUDA10_Registers_Kernel.h"
#define SALT 902
#include "CUDA10_Registers_Kernel.h"
#define SALT 903
#include "CUDA10_Registers_Kernel.h"
#define SALT 904
#include "CUDA10_Registers_Kernel.h"
#define SALT 905
#include "CUDA10_Registers_Kernel.h"
#define SALT 906
#include "CUDA10_Registers_Kernel.h"
#define SALT 907
#include "CUDA10_Registers_Kernel.h"
#define SALT 908
#include "CUDA10_Registers_Kernel.h"
#define SALT 909
#include "CUDA10_Registers_Kernel.h"
#define SALT 910
#include "CUDA10_Registers_Kernel.h"
#define SALT 911
#include "CUDA10_Registers_Kernel.h"
#define SALT 912
#include "CUDA10_Registers_Kernel.h"
#define SALT 913
#include "CUDA10_Registers_Kernel.h"
#define SALT 914
#include "CUDA10_Registers_Kernel.h"
#define SALT 915
#include "CUDA10_Registers_Kernel.h"
#define SALT 916
#include "CUDA10_Registers_Kernel.h"
#define SALT 917
#include "CUDA10_Registers_Kernel.h"
#define SALT 918
#include "CUDA10_Registers_Kernel.h"
#define SALT 919
#include "CUDA10_Registers_Kernel.h"
#define SALT 920
#include "CUDA10_Registers_Kernel.h"
#define SALT 921
#include "CUDA10_Registers_Kernel.h"
#define SALT 922
#include "CUDA10_Registers_Kernel.h"
#define SALT 923
#include "CUDA10_Registers_Kernel.h"
#define SALT 924
#include "CUDA10_Registers_Kernel.h"
#define SALT 925
#include "CUDA10_Registers_Kernel.h"
#define SALT 926
#include "CUDA10_Registers_Kernel.h"
#define SALT 927
#include "CUDA10_Registers_Kernel.h"
#define SALT 928
#include "CUDA10_Registers_Kernel.h"
#define SALT 929
#include "CUDA10_Registers_Kernel.h"
#define SALT 930
#include "CUDA10_Registers_Kernel.h"
#define SALT 931
#include "CUDA10_Registers_Kernel.h"
#define SALT 932
#include "CUDA10_Registers_Kernel.h"
#define SALT 933
#include "CUDA10_Registers_Kernel.h"
#define SALT 934
#include "CUDA10_Registers_Kernel.h"
#define SALT 935
#include "CUDA10_Registers_Kernel.h"
#define SALT 936
#include "CUDA10_Registers_Kernel.h"
#define SALT 937
#include "CUDA10_Registers_Kernel.h"
#define SALT 938
#include "CUDA10_Registers_Kernel.h"
#define SALT 939
#include "CUDA10_Registers_Kernel.h"
#define SALT 940
#include "CUDA10_Registers_Kernel.h"
#define SALT 941
#include "CUDA10_Registers_Kernel.h"
#define SALT 942
#include "CUDA10_Registers_Kernel.h"
#define SALT 943
#include "CUDA10_Registers_Kernel.h"
#define SALT 944
#include "CUDA10_Registers_Kernel.h"
#define SALT 945
#include "CUDA10_Registers_Kernel.h"
#define SALT 946
#include "CUDA10_Registers_Kernel.h"
#define SALT 947
#include "CUDA10_Registers_Kernel.h"
#define SALT 948
#include "CUDA10_Registers_Kernel.h"
#define SALT 949
#include "CUDA10_Registers_Kernel.h"
#define SALT 950
#include "CUDA10_Registers_Kernel.h"
#define SALT 951
#include "CUDA10_Registers_Kernel.h"
#define SALT 952
#include "CUDA10_Registers_Kernel.h"
#define SALT 953
#include "CUDA10_Registers_Kernel.h"
#define SALT 954
#include "CUDA10_Registers_Kernel.h"
#define SALT 955
#include "CUDA10_Registers_Kernel.h"
#define SALT 956
#include "CUDA10_Registers_Kernel.h"
#define SALT 957
#include "CUDA10_Registers_Kernel.h"
#define SALT 958
#include "CUDA10_Registers_Kernel.h"
#define SALT 959
#include "CUDA10_Registers_Kernel.h"
#define SALT 960
#include "CUDA10_Registers_Kernel.h"
#define SALT 961
#include "CUDA10_Registers_Kernel.h"
#define SALT 962
#include "CUDA10_Registers_Kernel.h"
#define SALT 963
#include "CUDA10_Registers_Kernel.h"
#define SALT 964
#include "CUDA10_Registers_Kernel.h"
#define SALT 965
#include "CUDA10_Registers_Kernel.h"
#define SALT 966
#include "CUDA10_Registers_Kernel.h"
#define SALT 967
#include "CUDA10_Registers_Kernel.h"
#define SALT 968
#include "CUDA10_Registers_Kernel.h"
#define SALT 969
#include "CUDA10_Registers_Kernel.h"
#define SALT 970
#include "CUDA10_Registers_Kernel.h"
#define SALT 971
#include "CUDA10_Registers_Kernel.h"
#define SALT 972
#include "CUDA10_Registers_Kernel.h"
#define SALT 973
#include "CUDA10_Registers_Kernel.h"
#define SALT 974
#include "CUDA10_Registers_Kernel.h"
#define SALT 975
#include "CUDA10_Registers_Kernel.h"
#define SALT 976
#include "CUDA10_Registers_Kernel.h"
#define SALT 977
#include "CUDA10_Registers_Kernel.h"
#define SALT 978
#include "CUDA10_Registers_Kernel.h"
#define SALT 979
#include "CUDA10_Registers_Kernel.h"
#define SALT 980
#include "CUDA10_Registers_Kernel.h"
#define SALT 981
#include "CUDA10_Registers_Kernel.h"
#define SALT 982
#include "CUDA10_Registers_Kernel.h"
#define SALT 983
#include "CUDA10_Registers_Kernel.h"
#define SALT 984
#include "CUDA10_Registers_Kernel.h"
#define SALT 985
#include "CUDA10_Registers_Kernel.h"
#define SALT 986
#include "CUDA10_Registers_Kernel.h"
#define SALT 987
#include "CUDA10_Registers_Kernel.h"
#define SALT 988
#include "CUDA10_Registers_Kernel.h"
#define SALT 989
#include "CUDA10_Registers_Kernel.h"
#define SALT 990
#include "CUDA10_Registers_Kernel.h"
#define SALT 991
#include "CUDA10_Registers_Kernel.h"
#define SALT 992
#include "CUDA10_Registers_Kernel.h"
#define SALT 993
#include "CUDA10_Registers_Kernel.h"
#define SALT 994
#include "CUDA10_Registers_Kernel.h"
#define SALT 995
#include "CUDA10_Registers_Kernel.h"
#define SALT 996
#include "CUDA10_Registers_Kernel.h"
#define SALT 997
#include "CUDA10_Registers_Kernel.h"
#define SALT 998
#include "CUDA10_Registers_Kernel.h"
#define SALT 999
#include "CUDA10_Registers_Kernel.h"
#define SALT 1000
#include "CUDA10_Registers_Kernel.h"
#define SALT 1001
#include "CUDA10_Registers_Kernel.h"
#define SALT 1002
#include "CUDA10_Registers_Kernel.h"
#define SALT 1003
#include "CUDA10_Registers_Kernel.h"
#define SALT 1004
#include "CUDA10_Registers_Kernel.h"
#define SALT 1005
#include "CUDA10_Registers_Kernel.h"
#define SALT 1006
#include "CUDA10_Registers_Kernel.h"
#define SALT 1007
#include "CUDA10_Registers_Kernel.h"
#define SALT 1008
#include "CUDA10_Registers_Kernel.h"
#define SALT 1009
#include "CUDA10_Registers_Kernel.h"
#define SALT 1010
#include "CUDA10_Registers_Kernel.h"
#define SALT 1011
#include "CUDA10_Registers_Kernel.h"
#define SALT 1012
#include "CUDA10_Registers_Kernel.h"
#define SALT 1013
#include "CUDA10_Registers_Kernel.h"
#define SALT 1014
#include "CUDA10_Registers_Kernel.h"
#define SALT 1015
#include "CUDA10_Registers_Kernel.h"
#define SALT 1016
#include "CUDA10_Registers_Kernel.h"
#define SALT 1017
#include "CUDA10_Registers_Kernel.h"
#define SALT 1018
#include "CUDA10_Registers_Kernel.h"
#define SALT 1019
#include "CUDA10_Registers_Kernel.h"
#define SALT 1020
#include "CUDA10_Registers_Kernel.h"
#define SALT 1021
#include "CUDA10_Registers_Kernel.h"
#define SALT 1022
#include "CUDA10_Registers_Kernel.h"
#define SALT 1023
#include "CUDA10_Registers_Kernel.h"



void CUDA_DES_InitializeKernelLauncher1()
{
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,    compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
}

void CUDA_DES_LaunchKernel1(
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
		case 512: LAUNCH_KERNEL(512); break;
		case 513: LAUNCH_KERNEL(513); break;
		case 514: LAUNCH_KERNEL(514); break;
		case 515: LAUNCH_KERNEL(515); break;
		case 516: LAUNCH_KERNEL(516); break;
		case 517: LAUNCH_KERNEL(517); break;
		case 518: LAUNCH_KERNEL(518); break;
		case 519: LAUNCH_KERNEL(519); break;
		case 520: LAUNCH_KERNEL(520); break;
		case 521: LAUNCH_KERNEL(521); break;
		case 522: LAUNCH_KERNEL(522); break;
		case 523: LAUNCH_KERNEL(523); break;
		case 524: LAUNCH_KERNEL(524); break;
		case 525: LAUNCH_KERNEL(525); break;
		case 526: LAUNCH_KERNEL(526); break;
		case 527: LAUNCH_KERNEL(527); break;
		case 528: LAUNCH_KERNEL(528); break;
		case 529: LAUNCH_KERNEL(529); break;
		case 530: LAUNCH_KERNEL(530); break;
		case 531: LAUNCH_KERNEL(531); break;
		case 532: LAUNCH_KERNEL(532); break;
		case 533: LAUNCH_KERNEL(533); break;
		case 534: LAUNCH_KERNEL(534); break;
		case 535: LAUNCH_KERNEL(535); break;
		case 536: LAUNCH_KERNEL(536); break;
		case 537: LAUNCH_KERNEL(537); break;
		case 538: LAUNCH_KERNEL(538); break;
		case 539: LAUNCH_KERNEL(539); break;
		case 540: LAUNCH_KERNEL(540); break;
		case 541: LAUNCH_KERNEL(541); break;
		case 542: LAUNCH_KERNEL(542); break;
		case 543: LAUNCH_KERNEL(543); break;
		case 544: LAUNCH_KERNEL(544); break;
		case 545: LAUNCH_KERNEL(545); break;
		case 546: LAUNCH_KERNEL(546); break;
		case 547: LAUNCH_KERNEL(547); break;
		case 548: LAUNCH_KERNEL(548); break;
		case 549: LAUNCH_KERNEL(549); break;
		case 550: LAUNCH_KERNEL(550); break;
		case 551: LAUNCH_KERNEL(551); break;
		case 552: LAUNCH_KERNEL(552); break;
		case 553: LAUNCH_KERNEL(553); break;
		case 554: LAUNCH_KERNEL(554); break;
		case 555: LAUNCH_KERNEL(555); break;
		case 556: LAUNCH_KERNEL(556); break;
		case 557: LAUNCH_KERNEL(557); break;
		case 558: LAUNCH_KERNEL(558); break;
		case 559: LAUNCH_KERNEL(559); break;
		case 560: LAUNCH_KERNEL(560); break;
		case 561: LAUNCH_KERNEL(561); break;
		case 562: LAUNCH_KERNEL(562); break;
		case 563: LAUNCH_KERNEL(563); break;
		case 564: LAUNCH_KERNEL(564); break;
		case 565: LAUNCH_KERNEL(565); break;
		case 566: LAUNCH_KERNEL(566); break;
		case 567: LAUNCH_KERNEL(567); break;
		case 568: LAUNCH_KERNEL(568); break;
		case 569: LAUNCH_KERNEL(569); break;
		case 570: LAUNCH_KERNEL(570); break;
		case 571: LAUNCH_KERNEL(571); break;
		case 572: LAUNCH_KERNEL(572); break;
		case 573: LAUNCH_KERNEL(573); break;
		case 574: LAUNCH_KERNEL(574); break;
		case 575: LAUNCH_KERNEL(575); break;
		case 576: LAUNCH_KERNEL(576); break;
		case 577: LAUNCH_KERNEL(577); break;
		case 578: LAUNCH_KERNEL(578); break;
		case 579: LAUNCH_KERNEL(579); break;
		case 580: LAUNCH_KERNEL(580); break;
		case 581: LAUNCH_KERNEL(581); break;
		case 582: LAUNCH_KERNEL(582); break;
		case 583: LAUNCH_KERNEL(583); break;
		case 584: LAUNCH_KERNEL(584); break;
		case 585: LAUNCH_KERNEL(585); break;
		case 586: LAUNCH_KERNEL(586); break;
		case 587: LAUNCH_KERNEL(587); break;
		case 588: LAUNCH_KERNEL(588); break;
		case 589: LAUNCH_KERNEL(589); break;
		case 590: LAUNCH_KERNEL(590); break;
		case 591: LAUNCH_KERNEL(591); break;
		case 592: LAUNCH_KERNEL(592); break;
		case 593: LAUNCH_KERNEL(593); break;
		case 594: LAUNCH_KERNEL(594); break;
		case 595: LAUNCH_KERNEL(595); break;
		case 596: LAUNCH_KERNEL(596); break;
		case 597: LAUNCH_KERNEL(597); break;
		case 598: LAUNCH_KERNEL(598); break;
		case 599: LAUNCH_KERNEL(599); break;
		case 600: LAUNCH_KERNEL(600); break;
		case 601: LAUNCH_KERNEL(601); break;
		case 602: LAUNCH_KERNEL(602); break;
		case 603: LAUNCH_KERNEL(603); break;
		case 604: LAUNCH_KERNEL(604); break;
		case 605: LAUNCH_KERNEL(605); break;
		case 606: LAUNCH_KERNEL(606); break;
		case 607: LAUNCH_KERNEL(607); break;
		case 608: LAUNCH_KERNEL(608); break;
		case 609: LAUNCH_KERNEL(609); break;
		case 610: LAUNCH_KERNEL(610); break;
		case 611: LAUNCH_KERNEL(611); break;
		case 612: LAUNCH_KERNEL(612); break;
		case 613: LAUNCH_KERNEL(613); break;
		case 614: LAUNCH_KERNEL(614); break;
		case 615: LAUNCH_KERNEL(615); break;
		case 616: LAUNCH_KERNEL(616); break;
		case 617: LAUNCH_KERNEL(617); break;
		case 618: LAUNCH_KERNEL(618); break;
		case 619: LAUNCH_KERNEL(619); break;
		case 620: LAUNCH_KERNEL(620); break;
		case 621: LAUNCH_KERNEL(621); break;
		case 622: LAUNCH_KERNEL(622); break;
		case 623: LAUNCH_KERNEL(623); break;
		case 624: LAUNCH_KERNEL(624); break;
		case 625: LAUNCH_KERNEL(625); break;
		case 626: LAUNCH_KERNEL(626); break;
		case 627: LAUNCH_KERNEL(627); break;
		case 628: LAUNCH_KERNEL(628); break;
		case 629: LAUNCH_KERNEL(629); break;
		case 630: LAUNCH_KERNEL(630); break;
		case 631: LAUNCH_KERNEL(631); break;
		case 632: LAUNCH_KERNEL(632); break;
		case 633: LAUNCH_KERNEL(633); break;
		case 634: LAUNCH_KERNEL(634); break;
		case 635: LAUNCH_KERNEL(635); break;
		case 636: LAUNCH_KERNEL(636); break;
		case 637: LAUNCH_KERNEL(637); break;
		case 638: LAUNCH_KERNEL(638); break;
		case 639: LAUNCH_KERNEL(639); break;
		case 640: LAUNCH_KERNEL(640); break;
		case 641: LAUNCH_KERNEL(641); break;
		case 642: LAUNCH_KERNEL(642); break;
		case 643: LAUNCH_KERNEL(643); break;
		case 644: LAUNCH_KERNEL(644); break;
		case 645: LAUNCH_KERNEL(645); break;
		case 646: LAUNCH_KERNEL(646); break;
		case 647: LAUNCH_KERNEL(647); break;
		case 648: LAUNCH_KERNEL(648); break;
		case 649: LAUNCH_KERNEL(649); break;
		case 650: LAUNCH_KERNEL(650); break;
		case 651: LAUNCH_KERNEL(651); break;
		case 652: LAUNCH_KERNEL(652); break;
		case 653: LAUNCH_KERNEL(653); break;
		case 654: LAUNCH_KERNEL(654); break;
		case 655: LAUNCH_KERNEL(655); break;
		case 656: LAUNCH_KERNEL(656); break;
		case 657: LAUNCH_KERNEL(657); break;
		case 658: LAUNCH_KERNEL(658); break;
		case 659: LAUNCH_KERNEL(659); break;
		case 660: LAUNCH_KERNEL(660); break;
		case 661: LAUNCH_KERNEL(661); break;
		case 662: LAUNCH_KERNEL(662); break;
		case 663: LAUNCH_KERNEL(663); break;
		case 664: LAUNCH_KERNEL(664); break;
		case 665: LAUNCH_KERNEL(665); break;
		case 666: LAUNCH_KERNEL(666); break;
		case 667: LAUNCH_KERNEL(667); break;
		case 668: LAUNCH_KERNEL(668); break;
		case 669: LAUNCH_KERNEL(669); break;
		case 670: LAUNCH_KERNEL(670); break;
		case 671: LAUNCH_KERNEL(671); break;
		case 672: LAUNCH_KERNEL(672); break;
		case 673: LAUNCH_KERNEL(673); break;
		case 674: LAUNCH_KERNEL(674); break;
		case 675: LAUNCH_KERNEL(675); break;
		case 676: LAUNCH_KERNEL(676); break;
		case 677: LAUNCH_KERNEL(677); break;
		case 678: LAUNCH_KERNEL(678); break;
		case 679: LAUNCH_KERNEL(679); break;
		case 680: LAUNCH_KERNEL(680); break;
		case 681: LAUNCH_KERNEL(681); break;
		case 682: LAUNCH_KERNEL(682); break;
		case 683: LAUNCH_KERNEL(683); break;
		case 684: LAUNCH_KERNEL(684); break;
		case 685: LAUNCH_KERNEL(685); break;
		case 686: LAUNCH_KERNEL(686); break;
		case 687: LAUNCH_KERNEL(687); break;
		case 688: LAUNCH_KERNEL(688); break;
		case 689: LAUNCH_KERNEL(689); break;
		case 690: LAUNCH_KERNEL(690); break;
		case 691: LAUNCH_KERNEL(691); break;
		case 692: LAUNCH_KERNEL(692); break;
		case 693: LAUNCH_KERNEL(693); break;
		case 694: LAUNCH_KERNEL(694); break;
		case 695: LAUNCH_KERNEL(695); break;
		case 696: LAUNCH_KERNEL(696); break;
		case 697: LAUNCH_KERNEL(697); break;
		case 698: LAUNCH_KERNEL(698); break;
		case 699: LAUNCH_KERNEL(699); break;
		case 700: LAUNCH_KERNEL(700); break;
		case 701: LAUNCH_KERNEL(701); break;
		case 702: LAUNCH_KERNEL(702); break;
		case 703: LAUNCH_KERNEL(703); break;
		case 704: LAUNCH_KERNEL(704); break;
		case 705: LAUNCH_KERNEL(705); break;
		case 706: LAUNCH_KERNEL(706); break;
		case 707: LAUNCH_KERNEL(707); break;
		case 708: LAUNCH_KERNEL(708); break;
		case 709: LAUNCH_KERNEL(709); break;
		case 710: LAUNCH_KERNEL(710); break;
		case 711: LAUNCH_KERNEL(711); break;
		case 712: LAUNCH_KERNEL(712); break;
		case 713: LAUNCH_KERNEL(713); break;
		case 714: LAUNCH_KERNEL(714); break;
		case 715: LAUNCH_KERNEL(715); break;
		case 716: LAUNCH_KERNEL(716); break;
		case 717: LAUNCH_KERNEL(717); break;
		case 718: LAUNCH_KERNEL(718); break;
		case 719: LAUNCH_KERNEL(719); break;
		case 720: LAUNCH_KERNEL(720); break;
		case 721: LAUNCH_KERNEL(721); break;
		case 722: LAUNCH_KERNEL(722); break;
		case 723: LAUNCH_KERNEL(723); break;
		case 724: LAUNCH_KERNEL(724); break;
		case 725: LAUNCH_KERNEL(725); break;
		case 726: LAUNCH_KERNEL(726); break;
		case 727: LAUNCH_KERNEL(727); break;
		case 728: LAUNCH_KERNEL(728); break;
		case 729: LAUNCH_KERNEL(729); break;
		case 730: LAUNCH_KERNEL(730); break;
		case 731: LAUNCH_KERNEL(731); break;
		case 732: LAUNCH_KERNEL(732); break;
		case 733: LAUNCH_KERNEL(733); break;
		case 734: LAUNCH_KERNEL(734); break;
		case 735: LAUNCH_KERNEL(735); break;
		case 736: LAUNCH_KERNEL(736); break;
		case 737: LAUNCH_KERNEL(737); break;
		case 738: LAUNCH_KERNEL(738); break;
		case 739: LAUNCH_KERNEL(739); break;
		case 740: LAUNCH_KERNEL(740); break;
		case 741: LAUNCH_KERNEL(741); break;
		case 742: LAUNCH_KERNEL(742); break;
		case 743: LAUNCH_KERNEL(743); break;
		case 744: LAUNCH_KERNEL(744); break;
		case 745: LAUNCH_KERNEL(745); break;
		case 746: LAUNCH_KERNEL(746); break;
		case 747: LAUNCH_KERNEL(747); break;
		case 748: LAUNCH_KERNEL(748); break;
		case 749: LAUNCH_KERNEL(749); break;
		case 750: LAUNCH_KERNEL(750); break;
		case 751: LAUNCH_KERNEL(751); break;
		case 752: LAUNCH_KERNEL(752); break;
		case 753: LAUNCH_KERNEL(753); break;
		case 754: LAUNCH_KERNEL(754); break;
		case 755: LAUNCH_KERNEL(755); break;
		case 756: LAUNCH_KERNEL(756); break;
		case 757: LAUNCH_KERNEL(757); break;
		case 758: LAUNCH_KERNEL(758); break;
		case 759: LAUNCH_KERNEL(759); break;
		case 760: LAUNCH_KERNEL(760); break;
		case 761: LAUNCH_KERNEL(761); break;
		case 762: LAUNCH_KERNEL(762); break;
		case 763: LAUNCH_KERNEL(763); break;
		case 764: LAUNCH_KERNEL(764); break;
		case 765: LAUNCH_KERNEL(765); break;
		case 766: LAUNCH_KERNEL(766); break;
		case 767: LAUNCH_KERNEL(767); break;
		case 768: LAUNCH_KERNEL(768); break;
		case 769: LAUNCH_KERNEL(769); break;
		case 770: LAUNCH_KERNEL(770); break;
		case 771: LAUNCH_KERNEL(771); break;
		case 772: LAUNCH_KERNEL(772); break;
		case 773: LAUNCH_KERNEL(773); break;
		case 774: LAUNCH_KERNEL(774); break;
		case 775: LAUNCH_KERNEL(775); break;
		case 776: LAUNCH_KERNEL(776); break;
		case 777: LAUNCH_KERNEL(777); break;
		case 778: LAUNCH_KERNEL(778); break;
		case 779: LAUNCH_KERNEL(779); break;
		case 780: LAUNCH_KERNEL(780); break;
		case 781: LAUNCH_KERNEL(781); break;
		case 782: LAUNCH_KERNEL(782); break;
		case 783: LAUNCH_KERNEL(783); break;
		case 784: LAUNCH_KERNEL(784); break;
		case 785: LAUNCH_KERNEL(785); break;
		case 786: LAUNCH_KERNEL(786); break;
		case 787: LAUNCH_KERNEL(787); break;
		case 788: LAUNCH_KERNEL(788); break;
		case 789: LAUNCH_KERNEL(789); break;
		case 790: LAUNCH_KERNEL(790); break;
		case 791: LAUNCH_KERNEL(791); break;
		case 792: LAUNCH_KERNEL(792); break;
		case 793: LAUNCH_KERNEL(793); break;
		case 794: LAUNCH_KERNEL(794); break;
		case 795: LAUNCH_KERNEL(795); break;
		case 796: LAUNCH_KERNEL(796); break;
		case 797: LAUNCH_KERNEL(797); break;
		case 798: LAUNCH_KERNEL(798); break;
		case 799: LAUNCH_KERNEL(799); break;
		case 800: LAUNCH_KERNEL(800); break;
		case 801: LAUNCH_KERNEL(801); break;
		case 802: LAUNCH_KERNEL(802); break;
		case 803: LAUNCH_KERNEL(803); break;
		case 804: LAUNCH_KERNEL(804); break;
		case 805: LAUNCH_KERNEL(805); break;
		case 806: LAUNCH_KERNEL(806); break;
		case 807: LAUNCH_KERNEL(807); break;
		case 808: LAUNCH_KERNEL(808); break;
		case 809: LAUNCH_KERNEL(809); break;
		case 810: LAUNCH_KERNEL(810); break;
		case 811: LAUNCH_KERNEL(811); break;
		case 812: LAUNCH_KERNEL(812); break;
		case 813: LAUNCH_KERNEL(813); break;
		case 814: LAUNCH_KERNEL(814); break;
		case 815: LAUNCH_KERNEL(815); break;
		case 816: LAUNCH_KERNEL(816); break;
		case 817: LAUNCH_KERNEL(817); break;
		case 818: LAUNCH_KERNEL(818); break;
		case 819: LAUNCH_KERNEL(819); break;
		case 820: LAUNCH_KERNEL(820); break;
		case 821: LAUNCH_KERNEL(821); break;
		case 822: LAUNCH_KERNEL(822); break;
		case 823: LAUNCH_KERNEL(823); break;
		case 824: LAUNCH_KERNEL(824); break;
		case 825: LAUNCH_KERNEL(825); break;
		case 826: LAUNCH_KERNEL(826); break;
		case 827: LAUNCH_KERNEL(827); break;
		case 828: LAUNCH_KERNEL(828); break;
		case 829: LAUNCH_KERNEL(829); break;
		case 830: LAUNCH_KERNEL(830); break;
		case 831: LAUNCH_KERNEL(831); break;
		case 832: LAUNCH_KERNEL(832); break;
		case 833: LAUNCH_KERNEL(833); break;
		case 834: LAUNCH_KERNEL(834); break;
		case 835: LAUNCH_KERNEL(835); break;
		case 836: LAUNCH_KERNEL(836); break;
		case 837: LAUNCH_KERNEL(837); break;
		case 838: LAUNCH_KERNEL(838); break;
		case 839: LAUNCH_KERNEL(839); break;
		case 840: LAUNCH_KERNEL(840); break;
		case 841: LAUNCH_KERNEL(841); break;
		case 842: LAUNCH_KERNEL(842); break;
		case 843: LAUNCH_KERNEL(843); break;
		case 844: LAUNCH_KERNEL(844); break;
		case 845: LAUNCH_KERNEL(845); break;
		case 846: LAUNCH_KERNEL(846); break;
		case 847: LAUNCH_KERNEL(847); break;
		case 848: LAUNCH_KERNEL(848); break;
		case 849: LAUNCH_KERNEL(849); break;
		case 850: LAUNCH_KERNEL(850); break;
		case 851: LAUNCH_KERNEL(851); break;
		case 852: LAUNCH_KERNEL(852); break;
		case 853: LAUNCH_KERNEL(853); break;
		case 854: LAUNCH_KERNEL(854); break;
		case 855: LAUNCH_KERNEL(855); break;
		case 856: LAUNCH_KERNEL(856); break;
		case 857: LAUNCH_KERNEL(857); break;
		case 858: LAUNCH_KERNEL(858); break;
		case 859: LAUNCH_KERNEL(859); break;
		case 860: LAUNCH_KERNEL(860); break;
		case 861: LAUNCH_KERNEL(861); break;
		case 862: LAUNCH_KERNEL(862); break;
		case 863: LAUNCH_KERNEL(863); break;
		case 864: LAUNCH_KERNEL(864); break;
		case 865: LAUNCH_KERNEL(865); break;
		case 866: LAUNCH_KERNEL(866); break;
		case 867: LAUNCH_KERNEL(867); break;
		case 868: LAUNCH_KERNEL(868); break;
		case 869: LAUNCH_KERNEL(869); break;
		case 870: LAUNCH_KERNEL(870); break;
		case 871: LAUNCH_KERNEL(871); break;
		case 872: LAUNCH_KERNEL(872); break;
		case 873: LAUNCH_KERNEL(873); break;
		case 874: LAUNCH_KERNEL(874); break;
		case 875: LAUNCH_KERNEL(875); break;
		case 876: LAUNCH_KERNEL(876); break;
		case 877: LAUNCH_KERNEL(877); break;
		case 878: LAUNCH_KERNEL(878); break;
		case 879: LAUNCH_KERNEL(879); break;
		case 880: LAUNCH_KERNEL(880); break;
		case 881: LAUNCH_KERNEL(881); break;
		case 882: LAUNCH_KERNEL(882); break;
		case 883: LAUNCH_KERNEL(883); break;
		case 884: LAUNCH_KERNEL(884); break;
		case 885: LAUNCH_KERNEL(885); break;
		case 886: LAUNCH_KERNEL(886); break;
		case 887: LAUNCH_KERNEL(887); break;
		case 888: LAUNCH_KERNEL(888); break;
		case 889: LAUNCH_KERNEL(889); break;
		case 890: LAUNCH_KERNEL(890); break;
		case 891: LAUNCH_KERNEL(891); break;
		case 892: LAUNCH_KERNEL(892); break;
		case 893: LAUNCH_KERNEL(893); break;
		case 894: LAUNCH_KERNEL(894); break;
		case 895: LAUNCH_KERNEL(895); break;
		case 896: LAUNCH_KERNEL(896); break;
		case 897: LAUNCH_KERNEL(897); break;
		case 898: LAUNCH_KERNEL(898); break;
		case 899: LAUNCH_KERNEL(899); break;
		case 900: LAUNCH_KERNEL(900); break;
		case 901: LAUNCH_KERNEL(901); break;
		case 902: LAUNCH_KERNEL(902); break;
		case 903: LAUNCH_KERNEL(903); break;
		case 904: LAUNCH_KERNEL(904); break;
		case 905: LAUNCH_KERNEL(905); break;
		case 906: LAUNCH_KERNEL(906); break;
		case 907: LAUNCH_KERNEL(907); break;
		case 908: LAUNCH_KERNEL(908); break;
		case 909: LAUNCH_KERNEL(909); break;
		case 910: LAUNCH_KERNEL(910); break;
		case 911: LAUNCH_KERNEL(911); break;
		case 912: LAUNCH_KERNEL(912); break;
		case 913: LAUNCH_KERNEL(913); break;
		case 914: LAUNCH_KERNEL(914); break;
		case 915: LAUNCH_KERNEL(915); break;
		case 916: LAUNCH_KERNEL(916); break;
		case 917: LAUNCH_KERNEL(917); break;
		case 918: LAUNCH_KERNEL(918); break;
		case 919: LAUNCH_KERNEL(919); break;
		case 920: LAUNCH_KERNEL(920); break;
		case 921: LAUNCH_KERNEL(921); break;
		case 922: LAUNCH_KERNEL(922); break;
		case 923: LAUNCH_KERNEL(923); break;
		case 924: LAUNCH_KERNEL(924); break;
		case 925: LAUNCH_KERNEL(925); break;
		case 926: LAUNCH_KERNEL(926); break;
		case 927: LAUNCH_KERNEL(927); break;
		case 928: LAUNCH_KERNEL(928); break;
		case 929: LAUNCH_KERNEL(929); break;
		case 930: LAUNCH_KERNEL(930); break;
		case 931: LAUNCH_KERNEL(931); break;
		case 932: LAUNCH_KERNEL(932); break;
		case 933: LAUNCH_KERNEL(933); break;
		case 934: LAUNCH_KERNEL(934); break;
		case 935: LAUNCH_KERNEL(935); break;
		case 936: LAUNCH_KERNEL(936); break;
		case 937: LAUNCH_KERNEL(937); break;
		case 938: LAUNCH_KERNEL(938); break;
		case 939: LAUNCH_KERNEL(939); break;
		case 940: LAUNCH_KERNEL(940); break;
		case 941: LAUNCH_KERNEL(941); break;
		case 942: LAUNCH_KERNEL(942); break;
		case 943: LAUNCH_KERNEL(943); break;
		case 944: LAUNCH_KERNEL(944); break;
		case 945: LAUNCH_KERNEL(945); break;
		case 946: LAUNCH_KERNEL(946); break;
		case 947: LAUNCH_KERNEL(947); break;
		case 948: LAUNCH_KERNEL(948); break;
		case 949: LAUNCH_KERNEL(949); break;
		case 950: LAUNCH_KERNEL(950); break;
		case 951: LAUNCH_KERNEL(951); break;
		case 952: LAUNCH_KERNEL(952); break;
		case 953: LAUNCH_KERNEL(953); break;
		case 954: LAUNCH_KERNEL(954); break;
		case 955: LAUNCH_KERNEL(955); break;
		case 956: LAUNCH_KERNEL(956); break;
		case 957: LAUNCH_KERNEL(957); break;
		case 958: LAUNCH_KERNEL(958); break;
		case 959: LAUNCH_KERNEL(959); break;
		case 960: LAUNCH_KERNEL(960); break;
		case 961: LAUNCH_KERNEL(961); break;
		case 962: LAUNCH_KERNEL(962); break;
		case 963: LAUNCH_KERNEL(963); break;
		case 964: LAUNCH_KERNEL(964); break;
		case 965: LAUNCH_KERNEL(965); break;
		case 966: LAUNCH_KERNEL(966); break;
		case 967: LAUNCH_KERNEL(967); break;
		case 968: LAUNCH_KERNEL(968); break;
		case 969: LAUNCH_KERNEL(969); break;
		case 970: LAUNCH_KERNEL(970); break;
		case 971: LAUNCH_KERNEL(971); break;
		case 972: LAUNCH_KERNEL(972); break;
		case 973: LAUNCH_KERNEL(973); break;
		case 974: LAUNCH_KERNEL(974); break;
		case 975: LAUNCH_KERNEL(975); break;
		case 976: LAUNCH_KERNEL(976); break;
		case 977: LAUNCH_KERNEL(977); break;
		case 978: LAUNCH_KERNEL(978); break;
		case 979: LAUNCH_KERNEL(979); break;
		case 980: LAUNCH_KERNEL(980); break;
		case 981: LAUNCH_KERNEL(981); break;
		case 982: LAUNCH_KERNEL(982); break;
		case 983: LAUNCH_KERNEL(983); break;
		case 984: LAUNCH_KERNEL(984); break;
		case 985: LAUNCH_KERNEL(985); break;
		case 986: LAUNCH_KERNEL(986); break;
		case 987: LAUNCH_KERNEL(987); break;
		case 988: LAUNCH_KERNEL(988); break;
		case 989: LAUNCH_KERNEL(989); break;
		case 990: LAUNCH_KERNEL(990); break;
		case 991: LAUNCH_KERNEL(991); break;
		case 992: LAUNCH_KERNEL(992); break;
		case 993: LAUNCH_KERNEL(993); break;
		case 994: LAUNCH_KERNEL(994); break;
		case 995: LAUNCH_KERNEL(995); break;
		case 996: LAUNCH_KERNEL(996); break;
		case 997: LAUNCH_KERNEL(997); break;
		case 998: LAUNCH_KERNEL(998); break;
		case 999: LAUNCH_KERNEL(999); break;
		case 1000: LAUNCH_KERNEL(1000); break;
		case 1001: LAUNCH_KERNEL(1001); break;
		case 1002: LAUNCH_KERNEL(1002); break;
		case 1003: LAUNCH_KERNEL(1003); break;
		case 1004: LAUNCH_KERNEL(1004); break;
		case 1005: LAUNCH_KERNEL(1005); break;
		case 1006: LAUNCH_KERNEL(1006); break;
		case 1007: LAUNCH_KERNEL(1007); break;
		case 1008: LAUNCH_KERNEL(1008); break;
		case 1009: LAUNCH_KERNEL(1009); break;
		case 1010: LAUNCH_KERNEL(1010); break;
		case 1011: LAUNCH_KERNEL(1011); break;
		case 1012: LAUNCH_KERNEL(1012); break;
		case 1013: LAUNCH_KERNEL(1013); break;
		case 1014: LAUNCH_KERNEL(1014); break;
		case 1015: LAUNCH_KERNEL(1015); break;
		case 1016: LAUNCH_KERNEL(1016); break;
		case 1017: LAUNCH_KERNEL(1017); break;
		case 1018: LAUNCH_KERNEL(1018); break;
		case 1019: LAUNCH_KERNEL(1019); break;
		case 1020: LAUNCH_KERNEL(1020); break;
		case 1021: LAUNCH_KERNEL(1021); break;
		case 1022: LAUNCH_KERNEL(1022); break;
		case 1023: LAUNCH_KERNEL(1023); break;
		default: ASSERT(FALSE);
	}
}

#endif
