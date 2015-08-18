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

#define SALT 2560
#include "CUDA10_Registers_Kernel.h"
#define SALT 2561
#include "CUDA10_Registers_Kernel.h"
#define SALT 2562
#include "CUDA10_Registers_Kernel.h"
#define SALT 2563
#include "CUDA10_Registers_Kernel.h"
#define SALT 2564
#include "CUDA10_Registers_Kernel.h"
#define SALT 2565
#include "CUDA10_Registers_Kernel.h"
#define SALT 2566
#include "CUDA10_Registers_Kernel.h"
#define SALT 2567
#include "CUDA10_Registers_Kernel.h"
#define SALT 2568
#include "CUDA10_Registers_Kernel.h"
#define SALT 2569
#include "CUDA10_Registers_Kernel.h"
#define SALT 2570
#include "CUDA10_Registers_Kernel.h"
#define SALT 2571
#include "CUDA10_Registers_Kernel.h"
#define SALT 2572
#include "CUDA10_Registers_Kernel.h"
#define SALT 2573
#include "CUDA10_Registers_Kernel.h"
#define SALT 2574
#include "CUDA10_Registers_Kernel.h"
#define SALT 2575
#include "CUDA10_Registers_Kernel.h"
#define SALT 2576
#include "CUDA10_Registers_Kernel.h"
#define SALT 2577
#include "CUDA10_Registers_Kernel.h"
#define SALT 2578
#include "CUDA10_Registers_Kernel.h"
#define SALT 2579
#include "CUDA10_Registers_Kernel.h"
#define SALT 2580
#include "CUDA10_Registers_Kernel.h"
#define SALT 2581
#include "CUDA10_Registers_Kernel.h"
#define SALT 2582
#include "CUDA10_Registers_Kernel.h"
#define SALT 2583
#include "CUDA10_Registers_Kernel.h"
#define SALT 2584
#include "CUDA10_Registers_Kernel.h"
#define SALT 2585
#include "CUDA10_Registers_Kernel.h"
#define SALT 2586
#include "CUDA10_Registers_Kernel.h"
#define SALT 2587
#include "CUDA10_Registers_Kernel.h"
#define SALT 2588
#include "CUDA10_Registers_Kernel.h"
#define SALT 2589
#include "CUDA10_Registers_Kernel.h"
#define SALT 2590
#include "CUDA10_Registers_Kernel.h"
#define SALT 2591
#include "CUDA10_Registers_Kernel.h"
#define SALT 2592
#include "CUDA10_Registers_Kernel.h"
#define SALT 2593
#include "CUDA10_Registers_Kernel.h"
#define SALT 2594
#include "CUDA10_Registers_Kernel.h"
#define SALT 2595
#include "CUDA10_Registers_Kernel.h"
#define SALT 2596
#include "CUDA10_Registers_Kernel.h"
#define SALT 2597
#include "CUDA10_Registers_Kernel.h"
#define SALT 2598
#include "CUDA10_Registers_Kernel.h"
#define SALT 2599
#include "CUDA10_Registers_Kernel.h"
#define SALT 2600
#include "CUDA10_Registers_Kernel.h"
#define SALT 2601
#include "CUDA10_Registers_Kernel.h"
#define SALT 2602
#include "CUDA10_Registers_Kernel.h"
#define SALT 2603
#include "CUDA10_Registers_Kernel.h"
#define SALT 2604
#include "CUDA10_Registers_Kernel.h"
#define SALT 2605
#include "CUDA10_Registers_Kernel.h"
#define SALT 2606
#include "CUDA10_Registers_Kernel.h"
#define SALT 2607
#include "CUDA10_Registers_Kernel.h"
#define SALT 2608
#include "CUDA10_Registers_Kernel.h"
#define SALT 2609
#include "CUDA10_Registers_Kernel.h"
#define SALT 2610
#include "CUDA10_Registers_Kernel.h"
#define SALT 2611
#include "CUDA10_Registers_Kernel.h"
#define SALT 2612
#include "CUDA10_Registers_Kernel.h"
#define SALT 2613
#include "CUDA10_Registers_Kernel.h"
#define SALT 2614
#include "CUDA10_Registers_Kernel.h"
#define SALT 2615
#include "CUDA10_Registers_Kernel.h"
#define SALT 2616
#include "CUDA10_Registers_Kernel.h"
#define SALT 2617
#include "CUDA10_Registers_Kernel.h"
#define SALT 2618
#include "CUDA10_Registers_Kernel.h"
#define SALT 2619
#include "CUDA10_Registers_Kernel.h"
#define SALT 2620
#include "CUDA10_Registers_Kernel.h"
#define SALT 2621
#include "CUDA10_Registers_Kernel.h"
#define SALT 2622
#include "CUDA10_Registers_Kernel.h"
#define SALT 2623
#include "CUDA10_Registers_Kernel.h"
#define SALT 2624
#include "CUDA10_Registers_Kernel.h"
#define SALT 2625
#include "CUDA10_Registers_Kernel.h"
#define SALT 2626
#include "CUDA10_Registers_Kernel.h"
#define SALT 2627
#include "CUDA10_Registers_Kernel.h"
#define SALT 2628
#include "CUDA10_Registers_Kernel.h"
#define SALT 2629
#include "CUDA10_Registers_Kernel.h"
#define SALT 2630
#include "CUDA10_Registers_Kernel.h"
#define SALT 2631
#include "CUDA10_Registers_Kernel.h"
#define SALT 2632
#include "CUDA10_Registers_Kernel.h"
#define SALT 2633
#include "CUDA10_Registers_Kernel.h"
#define SALT 2634
#include "CUDA10_Registers_Kernel.h"
#define SALT 2635
#include "CUDA10_Registers_Kernel.h"
#define SALT 2636
#include "CUDA10_Registers_Kernel.h"
#define SALT 2637
#include "CUDA10_Registers_Kernel.h"
#define SALT 2638
#include "CUDA10_Registers_Kernel.h"
#define SALT 2639
#include "CUDA10_Registers_Kernel.h"
#define SALT 2640
#include "CUDA10_Registers_Kernel.h"
#define SALT 2641
#include "CUDA10_Registers_Kernel.h"
#define SALT 2642
#include "CUDA10_Registers_Kernel.h"
#define SALT 2643
#include "CUDA10_Registers_Kernel.h"
#define SALT 2644
#include "CUDA10_Registers_Kernel.h"
#define SALT 2645
#include "CUDA10_Registers_Kernel.h"
#define SALT 2646
#include "CUDA10_Registers_Kernel.h"
#define SALT 2647
#include "CUDA10_Registers_Kernel.h"
#define SALT 2648
#include "CUDA10_Registers_Kernel.h"
#define SALT 2649
#include "CUDA10_Registers_Kernel.h"
#define SALT 2650
#include "CUDA10_Registers_Kernel.h"
#define SALT 2651
#include "CUDA10_Registers_Kernel.h"
#define SALT 2652
#include "CUDA10_Registers_Kernel.h"
#define SALT 2653
#include "CUDA10_Registers_Kernel.h"
#define SALT 2654
#include "CUDA10_Registers_Kernel.h"
#define SALT 2655
#include "CUDA10_Registers_Kernel.h"
#define SALT 2656
#include "CUDA10_Registers_Kernel.h"
#define SALT 2657
#include "CUDA10_Registers_Kernel.h"
#define SALT 2658
#include "CUDA10_Registers_Kernel.h"
#define SALT 2659
#include "CUDA10_Registers_Kernel.h"
#define SALT 2660
#include "CUDA10_Registers_Kernel.h"
#define SALT 2661
#include "CUDA10_Registers_Kernel.h"
#define SALT 2662
#include "CUDA10_Registers_Kernel.h"
#define SALT 2663
#include "CUDA10_Registers_Kernel.h"
#define SALT 2664
#include "CUDA10_Registers_Kernel.h"
#define SALT 2665
#include "CUDA10_Registers_Kernel.h"
#define SALT 2666
#include "CUDA10_Registers_Kernel.h"
#define SALT 2667
#include "CUDA10_Registers_Kernel.h"
#define SALT 2668
#include "CUDA10_Registers_Kernel.h"
#define SALT 2669
#include "CUDA10_Registers_Kernel.h"
#define SALT 2670
#include "CUDA10_Registers_Kernel.h"
#define SALT 2671
#include "CUDA10_Registers_Kernel.h"
#define SALT 2672
#include "CUDA10_Registers_Kernel.h"
#define SALT 2673
#include "CUDA10_Registers_Kernel.h"
#define SALT 2674
#include "CUDA10_Registers_Kernel.h"
#define SALT 2675
#include "CUDA10_Registers_Kernel.h"
#define SALT 2676
#include "CUDA10_Registers_Kernel.h"
#define SALT 2677
#include "CUDA10_Registers_Kernel.h"
#define SALT 2678
#include "CUDA10_Registers_Kernel.h"
#define SALT 2679
#include "CUDA10_Registers_Kernel.h"
#define SALT 2680
#include "CUDA10_Registers_Kernel.h"
#define SALT 2681
#include "CUDA10_Registers_Kernel.h"
#define SALT 2682
#include "CUDA10_Registers_Kernel.h"
#define SALT 2683
#include "CUDA10_Registers_Kernel.h"
#define SALT 2684
#include "CUDA10_Registers_Kernel.h"
#define SALT 2685
#include "CUDA10_Registers_Kernel.h"
#define SALT 2686
#include "CUDA10_Registers_Kernel.h"
#define SALT 2687
#include "CUDA10_Registers_Kernel.h"
#define SALT 2688
#include "CUDA10_Registers_Kernel.h"
#define SALT 2689
#include "CUDA10_Registers_Kernel.h"
#define SALT 2690
#include "CUDA10_Registers_Kernel.h"
#define SALT 2691
#include "CUDA10_Registers_Kernel.h"
#define SALT 2692
#include "CUDA10_Registers_Kernel.h"
#define SALT 2693
#include "CUDA10_Registers_Kernel.h"
#define SALT 2694
#include "CUDA10_Registers_Kernel.h"
#define SALT 2695
#include "CUDA10_Registers_Kernel.h"
#define SALT 2696
#include "CUDA10_Registers_Kernel.h"
#define SALT 2697
#include "CUDA10_Registers_Kernel.h"
#define SALT 2698
#include "CUDA10_Registers_Kernel.h"
#define SALT 2699
#include "CUDA10_Registers_Kernel.h"
#define SALT 2700
#include "CUDA10_Registers_Kernel.h"
#define SALT 2701
#include "CUDA10_Registers_Kernel.h"
#define SALT 2702
#include "CUDA10_Registers_Kernel.h"
#define SALT 2703
#include "CUDA10_Registers_Kernel.h"
#define SALT 2704
#include "CUDA10_Registers_Kernel.h"
#define SALT 2705
#include "CUDA10_Registers_Kernel.h"
#define SALT 2706
#include "CUDA10_Registers_Kernel.h"
#define SALT 2707
#include "CUDA10_Registers_Kernel.h"
#define SALT 2708
#include "CUDA10_Registers_Kernel.h"
#define SALT 2709
#include "CUDA10_Registers_Kernel.h"
#define SALT 2710
#include "CUDA10_Registers_Kernel.h"
#define SALT 2711
#include "CUDA10_Registers_Kernel.h"
#define SALT 2712
#include "CUDA10_Registers_Kernel.h"
#define SALT 2713
#include "CUDA10_Registers_Kernel.h"
#define SALT 2714
#include "CUDA10_Registers_Kernel.h"
#define SALT 2715
#include "CUDA10_Registers_Kernel.h"
#define SALT 2716
#include "CUDA10_Registers_Kernel.h"
#define SALT 2717
#include "CUDA10_Registers_Kernel.h"
#define SALT 2718
#include "CUDA10_Registers_Kernel.h"
#define SALT 2719
#include "CUDA10_Registers_Kernel.h"
#define SALT 2720
#include "CUDA10_Registers_Kernel.h"
#define SALT 2721
#include "CUDA10_Registers_Kernel.h"
#define SALT 2722
#include "CUDA10_Registers_Kernel.h"
#define SALT 2723
#include "CUDA10_Registers_Kernel.h"
#define SALT 2724
#include "CUDA10_Registers_Kernel.h"
#define SALT 2725
#include "CUDA10_Registers_Kernel.h"
#define SALT 2726
#include "CUDA10_Registers_Kernel.h"
#define SALT 2727
#include "CUDA10_Registers_Kernel.h"
#define SALT 2728
#include "CUDA10_Registers_Kernel.h"
#define SALT 2729
#include "CUDA10_Registers_Kernel.h"
#define SALT 2730
#include "CUDA10_Registers_Kernel.h"
#define SALT 2731
#include "CUDA10_Registers_Kernel.h"
#define SALT 2732
#include "CUDA10_Registers_Kernel.h"
#define SALT 2733
#include "CUDA10_Registers_Kernel.h"
#define SALT 2734
#include "CUDA10_Registers_Kernel.h"
#define SALT 2735
#include "CUDA10_Registers_Kernel.h"
#define SALT 2736
#include "CUDA10_Registers_Kernel.h"
#define SALT 2737
#include "CUDA10_Registers_Kernel.h"
#define SALT 2738
#include "CUDA10_Registers_Kernel.h"
#define SALT 2739
#include "CUDA10_Registers_Kernel.h"
#define SALT 2740
#include "CUDA10_Registers_Kernel.h"
#define SALT 2741
#include "CUDA10_Registers_Kernel.h"
#define SALT 2742
#include "CUDA10_Registers_Kernel.h"
#define SALT 2743
#include "CUDA10_Registers_Kernel.h"
#define SALT 2744
#include "CUDA10_Registers_Kernel.h"
#define SALT 2745
#include "CUDA10_Registers_Kernel.h"
#define SALT 2746
#include "CUDA10_Registers_Kernel.h"
#define SALT 2747
#include "CUDA10_Registers_Kernel.h"
#define SALT 2748
#include "CUDA10_Registers_Kernel.h"
#define SALT 2749
#include "CUDA10_Registers_Kernel.h"
#define SALT 2750
#include "CUDA10_Registers_Kernel.h"
#define SALT 2751
#include "CUDA10_Registers_Kernel.h"
#define SALT 2752
#include "CUDA10_Registers_Kernel.h"
#define SALT 2753
#include "CUDA10_Registers_Kernel.h"
#define SALT 2754
#include "CUDA10_Registers_Kernel.h"
#define SALT 2755
#include "CUDA10_Registers_Kernel.h"
#define SALT 2756
#include "CUDA10_Registers_Kernel.h"
#define SALT 2757
#include "CUDA10_Registers_Kernel.h"
#define SALT 2758
#include "CUDA10_Registers_Kernel.h"
#define SALT 2759
#include "CUDA10_Registers_Kernel.h"
#define SALT 2760
#include "CUDA10_Registers_Kernel.h"
#define SALT 2761
#include "CUDA10_Registers_Kernel.h"
#define SALT 2762
#include "CUDA10_Registers_Kernel.h"
#define SALT 2763
#include "CUDA10_Registers_Kernel.h"
#define SALT 2764
#include "CUDA10_Registers_Kernel.h"
#define SALT 2765
#include "CUDA10_Registers_Kernel.h"
#define SALT 2766
#include "CUDA10_Registers_Kernel.h"
#define SALT 2767
#include "CUDA10_Registers_Kernel.h"
#define SALT 2768
#include "CUDA10_Registers_Kernel.h"
#define SALT 2769
#include "CUDA10_Registers_Kernel.h"
#define SALT 2770
#include "CUDA10_Registers_Kernel.h"
#define SALT 2771
#include "CUDA10_Registers_Kernel.h"
#define SALT 2772
#include "CUDA10_Registers_Kernel.h"
#define SALT 2773
#include "CUDA10_Registers_Kernel.h"
#define SALT 2774
#include "CUDA10_Registers_Kernel.h"
#define SALT 2775
#include "CUDA10_Registers_Kernel.h"
#define SALT 2776
#include "CUDA10_Registers_Kernel.h"
#define SALT 2777
#include "CUDA10_Registers_Kernel.h"
#define SALT 2778
#include "CUDA10_Registers_Kernel.h"
#define SALT 2779
#include "CUDA10_Registers_Kernel.h"
#define SALT 2780
#include "CUDA10_Registers_Kernel.h"
#define SALT 2781
#include "CUDA10_Registers_Kernel.h"
#define SALT 2782
#include "CUDA10_Registers_Kernel.h"
#define SALT 2783
#include "CUDA10_Registers_Kernel.h"
#define SALT 2784
#include "CUDA10_Registers_Kernel.h"
#define SALT 2785
#include "CUDA10_Registers_Kernel.h"
#define SALT 2786
#include "CUDA10_Registers_Kernel.h"
#define SALT 2787
#include "CUDA10_Registers_Kernel.h"
#define SALT 2788
#include "CUDA10_Registers_Kernel.h"
#define SALT 2789
#include "CUDA10_Registers_Kernel.h"
#define SALT 2790
#include "CUDA10_Registers_Kernel.h"
#define SALT 2791
#include "CUDA10_Registers_Kernel.h"
#define SALT 2792
#include "CUDA10_Registers_Kernel.h"
#define SALT 2793
#include "CUDA10_Registers_Kernel.h"
#define SALT 2794
#include "CUDA10_Registers_Kernel.h"
#define SALT 2795
#include "CUDA10_Registers_Kernel.h"
#define SALT 2796
#include "CUDA10_Registers_Kernel.h"
#define SALT 2797
#include "CUDA10_Registers_Kernel.h"
#define SALT 2798
#include "CUDA10_Registers_Kernel.h"
#define SALT 2799
#include "CUDA10_Registers_Kernel.h"
#define SALT 2800
#include "CUDA10_Registers_Kernel.h"
#define SALT 2801
#include "CUDA10_Registers_Kernel.h"
#define SALT 2802
#include "CUDA10_Registers_Kernel.h"
#define SALT 2803
#include "CUDA10_Registers_Kernel.h"
#define SALT 2804
#include "CUDA10_Registers_Kernel.h"
#define SALT 2805
#include "CUDA10_Registers_Kernel.h"
#define SALT 2806
#include "CUDA10_Registers_Kernel.h"
#define SALT 2807
#include "CUDA10_Registers_Kernel.h"
#define SALT 2808
#include "CUDA10_Registers_Kernel.h"
#define SALT 2809
#include "CUDA10_Registers_Kernel.h"
#define SALT 2810
#include "CUDA10_Registers_Kernel.h"
#define SALT 2811
#include "CUDA10_Registers_Kernel.h"
#define SALT 2812
#include "CUDA10_Registers_Kernel.h"
#define SALT 2813
#include "CUDA10_Registers_Kernel.h"
#define SALT 2814
#include "CUDA10_Registers_Kernel.h"
#define SALT 2815
#include "CUDA10_Registers_Kernel.h"
#define SALT 2816
#include "CUDA10_Registers_Kernel.h"
#define SALT 2817
#include "CUDA10_Registers_Kernel.h"
#define SALT 2818
#include "CUDA10_Registers_Kernel.h"
#define SALT 2819
#include "CUDA10_Registers_Kernel.h"
#define SALT 2820
#include "CUDA10_Registers_Kernel.h"
#define SALT 2821
#include "CUDA10_Registers_Kernel.h"
#define SALT 2822
#include "CUDA10_Registers_Kernel.h"
#define SALT 2823
#include "CUDA10_Registers_Kernel.h"
#define SALT 2824
#include "CUDA10_Registers_Kernel.h"
#define SALT 2825
#include "CUDA10_Registers_Kernel.h"
#define SALT 2826
#include "CUDA10_Registers_Kernel.h"
#define SALT 2827
#include "CUDA10_Registers_Kernel.h"
#define SALT 2828
#include "CUDA10_Registers_Kernel.h"
#define SALT 2829
#include "CUDA10_Registers_Kernel.h"
#define SALT 2830
#include "CUDA10_Registers_Kernel.h"
#define SALT 2831
#include "CUDA10_Registers_Kernel.h"
#define SALT 2832
#include "CUDA10_Registers_Kernel.h"
#define SALT 2833
#include "CUDA10_Registers_Kernel.h"
#define SALT 2834
#include "CUDA10_Registers_Kernel.h"
#define SALT 2835
#include "CUDA10_Registers_Kernel.h"
#define SALT 2836
#include "CUDA10_Registers_Kernel.h"
#define SALT 2837
#include "CUDA10_Registers_Kernel.h"
#define SALT 2838
#include "CUDA10_Registers_Kernel.h"
#define SALT 2839
#include "CUDA10_Registers_Kernel.h"
#define SALT 2840
#include "CUDA10_Registers_Kernel.h"
#define SALT 2841
#include "CUDA10_Registers_Kernel.h"
#define SALT 2842
#include "CUDA10_Registers_Kernel.h"
#define SALT 2843
#include "CUDA10_Registers_Kernel.h"
#define SALT 2844
#include "CUDA10_Registers_Kernel.h"
#define SALT 2845
#include "CUDA10_Registers_Kernel.h"
#define SALT 2846
#include "CUDA10_Registers_Kernel.h"
#define SALT 2847
#include "CUDA10_Registers_Kernel.h"
#define SALT 2848
#include "CUDA10_Registers_Kernel.h"
#define SALT 2849
#include "CUDA10_Registers_Kernel.h"
#define SALT 2850
#include "CUDA10_Registers_Kernel.h"
#define SALT 2851
#include "CUDA10_Registers_Kernel.h"
#define SALT 2852
#include "CUDA10_Registers_Kernel.h"
#define SALT 2853
#include "CUDA10_Registers_Kernel.h"
#define SALT 2854
#include "CUDA10_Registers_Kernel.h"
#define SALT 2855
#include "CUDA10_Registers_Kernel.h"
#define SALT 2856
#include "CUDA10_Registers_Kernel.h"
#define SALT 2857
#include "CUDA10_Registers_Kernel.h"
#define SALT 2858
#include "CUDA10_Registers_Kernel.h"
#define SALT 2859
#include "CUDA10_Registers_Kernel.h"
#define SALT 2860
#include "CUDA10_Registers_Kernel.h"
#define SALT 2861
#include "CUDA10_Registers_Kernel.h"
#define SALT 2862
#include "CUDA10_Registers_Kernel.h"
#define SALT 2863
#include "CUDA10_Registers_Kernel.h"
#define SALT 2864
#include "CUDA10_Registers_Kernel.h"
#define SALT 2865
#include "CUDA10_Registers_Kernel.h"
#define SALT 2866
#include "CUDA10_Registers_Kernel.h"
#define SALT 2867
#include "CUDA10_Registers_Kernel.h"
#define SALT 2868
#include "CUDA10_Registers_Kernel.h"
#define SALT 2869
#include "CUDA10_Registers_Kernel.h"
#define SALT 2870
#include "CUDA10_Registers_Kernel.h"
#define SALT 2871
#include "CUDA10_Registers_Kernel.h"
#define SALT 2872
#include "CUDA10_Registers_Kernel.h"
#define SALT 2873
#include "CUDA10_Registers_Kernel.h"
#define SALT 2874
#include "CUDA10_Registers_Kernel.h"
#define SALT 2875
#include "CUDA10_Registers_Kernel.h"
#define SALT 2876
#include "CUDA10_Registers_Kernel.h"
#define SALT 2877
#include "CUDA10_Registers_Kernel.h"
#define SALT 2878
#include "CUDA10_Registers_Kernel.h"
#define SALT 2879
#include "CUDA10_Registers_Kernel.h"
#define SALT 2880
#include "CUDA10_Registers_Kernel.h"
#define SALT 2881
#include "CUDA10_Registers_Kernel.h"
#define SALT 2882
#include "CUDA10_Registers_Kernel.h"
#define SALT 2883
#include "CUDA10_Registers_Kernel.h"
#define SALT 2884
#include "CUDA10_Registers_Kernel.h"
#define SALT 2885
#include "CUDA10_Registers_Kernel.h"
#define SALT 2886
#include "CUDA10_Registers_Kernel.h"
#define SALT 2887
#include "CUDA10_Registers_Kernel.h"
#define SALT 2888
#include "CUDA10_Registers_Kernel.h"
#define SALT 2889
#include "CUDA10_Registers_Kernel.h"
#define SALT 2890
#include "CUDA10_Registers_Kernel.h"
#define SALT 2891
#include "CUDA10_Registers_Kernel.h"
#define SALT 2892
#include "CUDA10_Registers_Kernel.h"
#define SALT 2893
#include "CUDA10_Registers_Kernel.h"
#define SALT 2894
#include "CUDA10_Registers_Kernel.h"
#define SALT 2895
#include "CUDA10_Registers_Kernel.h"
#define SALT 2896
#include "CUDA10_Registers_Kernel.h"
#define SALT 2897
#include "CUDA10_Registers_Kernel.h"
#define SALT 2898
#include "CUDA10_Registers_Kernel.h"
#define SALT 2899
#include "CUDA10_Registers_Kernel.h"
#define SALT 2900
#include "CUDA10_Registers_Kernel.h"
#define SALT 2901
#include "CUDA10_Registers_Kernel.h"
#define SALT 2902
#include "CUDA10_Registers_Kernel.h"
#define SALT 2903
#include "CUDA10_Registers_Kernel.h"
#define SALT 2904
#include "CUDA10_Registers_Kernel.h"
#define SALT 2905
#include "CUDA10_Registers_Kernel.h"
#define SALT 2906
#include "CUDA10_Registers_Kernel.h"
#define SALT 2907
#include "CUDA10_Registers_Kernel.h"
#define SALT 2908
#include "CUDA10_Registers_Kernel.h"
#define SALT 2909
#include "CUDA10_Registers_Kernel.h"
#define SALT 2910
#include "CUDA10_Registers_Kernel.h"
#define SALT 2911
#include "CUDA10_Registers_Kernel.h"
#define SALT 2912
#include "CUDA10_Registers_Kernel.h"
#define SALT 2913
#include "CUDA10_Registers_Kernel.h"
#define SALT 2914
#include "CUDA10_Registers_Kernel.h"
#define SALT 2915
#include "CUDA10_Registers_Kernel.h"
#define SALT 2916
#include "CUDA10_Registers_Kernel.h"
#define SALT 2917
#include "CUDA10_Registers_Kernel.h"
#define SALT 2918
#include "CUDA10_Registers_Kernel.h"
#define SALT 2919
#include "CUDA10_Registers_Kernel.h"
#define SALT 2920
#include "CUDA10_Registers_Kernel.h"
#define SALT 2921
#include "CUDA10_Registers_Kernel.h"
#define SALT 2922
#include "CUDA10_Registers_Kernel.h"
#define SALT 2923
#include "CUDA10_Registers_Kernel.h"
#define SALT 2924
#include "CUDA10_Registers_Kernel.h"
#define SALT 2925
#include "CUDA10_Registers_Kernel.h"
#define SALT 2926
#include "CUDA10_Registers_Kernel.h"
#define SALT 2927
#include "CUDA10_Registers_Kernel.h"
#define SALT 2928
#include "CUDA10_Registers_Kernel.h"
#define SALT 2929
#include "CUDA10_Registers_Kernel.h"
#define SALT 2930
#include "CUDA10_Registers_Kernel.h"
#define SALT 2931
#include "CUDA10_Registers_Kernel.h"
#define SALT 2932
#include "CUDA10_Registers_Kernel.h"
#define SALT 2933
#include "CUDA10_Registers_Kernel.h"
#define SALT 2934
#include "CUDA10_Registers_Kernel.h"
#define SALT 2935
#include "CUDA10_Registers_Kernel.h"
#define SALT 2936
#include "CUDA10_Registers_Kernel.h"
#define SALT 2937
#include "CUDA10_Registers_Kernel.h"
#define SALT 2938
#include "CUDA10_Registers_Kernel.h"
#define SALT 2939
#include "CUDA10_Registers_Kernel.h"
#define SALT 2940
#include "CUDA10_Registers_Kernel.h"
#define SALT 2941
#include "CUDA10_Registers_Kernel.h"
#define SALT 2942
#include "CUDA10_Registers_Kernel.h"
#define SALT 2943
#include "CUDA10_Registers_Kernel.h"
#define SALT 2944
#include "CUDA10_Registers_Kernel.h"
#define SALT 2945
#include "CUDA10_Registers_Kernel.h"
#define SALT 2946
#include "CUDA10_Registers_Kernel.h"
#define SALT 2947
#include "CUDA10_Registers_Kernel.h"
#define SALT 2948
#include "CUDA10_Registers_Kernel.h"
#define SALT 2949
#include "CUDA10_Registers_Kernel.h"
#define SALT 2950
#include "CUDA10_Registers_Kernel.h"
#define SALT 2951
#include "CUDA10_Registers_Kernel.h"
#define SALT 2952
#include "CUDA10_Registers_Kernel.h"
#define SALT 2953
#include "CUDA10_Registers_Kernel.h"
#define SALT 2954
#include "CUDA10_Registers_Kernel.h"
#define SALT 2955
#include "CUDA10_Registers_Kernel.h"
#define SALT 2956
#include "CUDA10_Registers_Kernel.h"
#define SALT 2957
#include "CUDA10_Registers_Kernel.h"
#define SALT 2958
#include "CUDA10_Registers_Kernel.h"
#define SALT 2959
#include "CUDA10_Registers_Kernel.h"
#define SALT 2960
#include "CUDA10_Registers_Kernel.h"
#define SALT 2961
#include "CUDA10_Registers_Kernel.h"
#define SALT 2962
#include "CUDA10_Registers_Kernel.h"
#define SALT 2963
#include "CUDA10_Registers_Kernel.h"
#define SALT 2964
#include "CUDA10_Registers_Kernel.h"
#define SALT 2965
#include "CUDA10_Registers_Kernel.h"
#define SALT 2966
#include "CUDA10_Registers_Kernel.h"
#define SALT 2967
#include "CUDA10_Registers_Kernel.h"
#define SALT 2968
#include "CUDA10_Registers_Kernel.h"
#define SALT 2969
#include "CUDA10_Registers_Kernel.h"
#define SALT 2970
#include "CUDA10_Registers_Kernel.h"
#define SALT 2971
#include "CUDA10_Registers_Kernel.h"
#define SALT 2972
#include "CUDA10_Registers_Kernel.h"
#define SALT 2973
#include "CUDA10_Registers_Kernel.h"
#define SALT 2974
#include "CUDA10_Registers_Kernel.h"
#define SALT 2975
#include "CUDA10_Registers_Kernel.h"
#define SALT 2976
#include "CUDA10_Registers_Kernel.h"
#define SALT 2977
#include "CUDA10_Registers_Kernel.h"
#define SALT 2978
#include "CUDA10_Registers_Kernel.h"
#define SALT 2979
#include "CUDA10_Registers_Kernel.h"
#define SALT 2980
#include "CUDA10_Registers_Kernel.h"
#define SALT 2981
#include "CUDA10_Registers_Kernel.h"
#define SALT 2982
#include "CUDA10_Registers_Kernel.h"
#define SALT 2983
#include "CUDA10_Registers_Kernel.h"
#define SALT 2984
#include "CUDA10_Registers_Kernel.h"
#define SALT 2985
#include "CUDA10_Registers_Kernel.h"
#define SALT 2986
#include "CUDA10_Registers_Kernel.h"
#define SALT 2987
#include "CUDA10_Registers_Kernel.h"
#define SALT 2988
#include "CUDA10_Registers_Kernel.h"
#define SALT 2989
#include "CUDA10_Registers_Kernel.h"
#define SALT 2990
#include "CUDA10_Registers_Kernel.h"
#define SALT 2991
#include "CUDA10_Registers_Kernel.h"
#define SALT 2992
#include "CUDA10_Registers_Kernel.h"
#define SALT 2993
#include "CUDA10_Registers_Kernel.h"
#define SALT 2994
#include "CUDA10_Registers_Kernel.h"
#define SALT 2995
#include "CUDA10_Registers_Kernel.h"
#define SALT 2996
#include "CUDA10_Registers_Kernel.h"
#define SALT 2997
#include "CUDA10_Registers_Kernel.h"
#define SALT 2998
#include "CUDA10_Registers_Kernel.h"
#define SALT 2999
#include "CUDA10_Registers_Kernel.h"
#define SALT 3000
#include "CUDA10_Registers_Kernel.h"
#define SALT 3001
#include "CUDA10_Registers_Kernel.h"
#define SALT 3002
#include "CUDA10_Registers_Kernel.h"
#define SALT 3003
#include "CUDA10_Registers_Kernel.h"
#define SALT 3004
#include "CUDA10_Registers_Kernel.h"
#define SALT 3005
#include "CUDA10_Registers_Kernel.h"
#define SALT 3006
#include "CUDA10_Registers_Kernel.h"
#define SALT 3007
#include "CUDA10_Registers_Kernel.h"
#define SALT 3008
#include "CUDA10_Registers_Kernel.h"
#define SALT 3009
#include "CUDA10_Registers_Kernel.h"
#define SALT 3010
#include "CUDA10_Registers_Kernel.h"
#define SALT 3011
#include "CUDA10_Registers_Kernel.h"
#define SALT 3012
#include "CUDA10_Registers_Kernel.h"
#define SALT 3013
#include "CUDA10_Registers_Kernel.h"
#define SALT 3014
#include "CUDA10_Registers_Kernel.h"
#define SALT 3015
#include "CUDA10_Registers_Kernel.h"
#define SALT 3016
#include "CUDA10_Registers_Kernel.h"
#define SALT 3017
#include "CUDA10_Registers_Kernel.h"
#define SALT 3018
#include "CUDA10_Registers_Kernel.h"
#define SALT 3019
#include "CUDA10_Registers_Kernel.h"
#define SALT 3020
#include "CUDA10_Registers_Kernel.h"
#define SALT 3021
#include "CUDA10_Registers_Kernel.h"
#define SALT 3022
#include "CUDA10_Registers_Kernel.h"
#define SALT 3023
#include "CUDA10_Registers_Kernel.h"
#define SALT 3024
#include "CUDA10_Registers_Kernel.h"
#define SALT 3025
#include "CUDA10_Registers_Kernel.h"
#define SALT 3026
#include "CUDA10_Registers_Kernel.h"
#define SALT 3027
#include "CUDA10_Registers_Kernel.h"
#define SALT 3028
#include "CUDA10_Registers_Kernel.h"
#define SALT 3029
#include "CUDA10_Registers_Kernel.h"
#define SALT 3030
#include "CUDA10_Registers_Kernel.h"
#define SALT 3031
#include "CUDA10_Registers_Kernel.h"
#define SALT 3032
#include "CUDA10_Registers_Kernel.h"
#define SALT 3033
#include "CUDA10_Registers_Kernel.h"
#define SALT 3034
#include "CUDA10_Registers_Kernel.h"
#define SALT 3035
#include "CUDA10_Registers_Kernel.h"
#define SALT 3036
#include "CUDA10_Registers_Kernel.h"
#define SALT 3037
#include "CUDA10_Registers_Kernel.h"
#define SALT 3038
#include "CUDA10_Registers_Kernel.h"
#define SALT 3039
#include "CUDA10_Registers_Kernel.h"
#define SALT 3040
#include "CUDA10_Registers_Kernel.h"
#define SALT 3041
#include "CUDA10_Registers_Kernel.h"
#define SALT 3042
#include "CUDA10_Registers_Kernel.h"
#define SALT 3043
#include "CUDA10_Registers_Kernel.h"
#define SALT 3044
#include "CUDA10_Registers_Kernel.h"
#define SALT 3045
#include "CUDA10_Registers_Kernel.h"
#define SALT 3046
#include "CUDA10_Registers_Kernel.h"
#define SALT 3047
#include "CUDA10_Registers_Kernel.h"
#define SALT 3048
#include "CUDA10_Registers_Kernel.h"
#define SALT 3049
#include "CUDA10_Registers_Kernel.h"
#define SALT 3050
#include "CUDA10_Registers_Kernel.h"
#define SALT 3051
#include "CUDA10_Registers_Kernel.h"
#define SALT 3052
#include "CUDA10_Registers_Kernel.h"
#define SALT 3053
#include "CUDA10_Registers_Kernel.h"
#define SALT 3054
#include "CUDA10_Registers_Kernel.h"
#define SALT 3055
#include "CUDA10_Registers_Kernel.h"
#define SALT 3056
#include "CUDA10_Registers_Kernel.h"
#define SALT 3057
#include "CUDA10_Registers_Kernel.h"
#define SALT 3058
#include "CUDA10_Registers_Kernel.h"
#define SALT 3059
#include "CUDA10_Registers_Kernel.h"
#define SALT 3060
#include "CUDA10_Registers_Kernel.h"
#define SALT 3061
#include "CUDA10_Registers_Kernel.h"
#define SALT 3062
#include "CUDA10_Registers_Kernel.h"
#define SALT 3063
#include "CUDA10_Registers_Kernel.h"
#define SALT 3064
#include "CUDA10_Registers_Kernel.h"
#define SALT 3065
#include "CUDA10_Registers_Kernel.h"
#define SALT 3066
#include "CUDA10_Registers_Kernel.h"
#define SALT 3067
#include "CUDA10_Registers_Kernel.h"
#define SALT 3068
#include "CUDA10_Registers_Kernel.h"
#define SALT 3069
#include "CUDA10_Registers_Kernel.h"
#define SALT 3070
#include "CUDA10_Registers_Kernel.h"
#define SALT 3071
#include "CUDA10_Registers_Kernel.h"



void CUDA_DES_InitializeKernelLauncher5()
{
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaChunkBitmap,               chunkBitmap,               CHUNK_BITMAP_SIZE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,    compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
}

void CUDA_DES_LaunchKernel5(
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
	case 2560: LAUNCH_KERNEL(2560); break;
	case 2561: LAUNCH_KERNEL(2561); break;
	case 2562: LAUNCH_KERNEL(2562); break;
	case 2563: LAUNCH_KERNEL(2563); break;
	case 2564: LAUNCH_KERNEL(2564); break;
	case 2565: LAUNCH_KERNEL(2565); break;
	case 2566: LAUNCH_KERNEL(2566); break;
	case 2567: LAUNCH_KERNEL(2567); break;
	case 2568: LAUNCH_KERNEL(2568); break;
	case 2569: LAUNCH_KERNEL(2569); break;
	case 2570: LAUNCH_KERNEL(2570); break;
	case 2571: LAUNCH_KERNEL(2571); break;
	case 2572: LAUNCH_KERNEL(2572); break;
	case 2573: LAUNCH_KERNEL(2573); break;
	case 2574: LAUNCH_KERNEL(2574); break;
	case 2575: LAUNCH_KERNEL(2575); break;
	case 2576: LAUNCH_KERNEL(2576); break;
	case 2577: LAUNCH_KERNEL(2577); break;
	case 2578: LAUNCH_KERNEL(2578); break;
	case 2579: LAUNCH_KERNEL(2579); break;
	case 2580: LAUNCH_KERNEL(2580); break;
	case 2581: LAUNCH_KERNEL(2581); break;
	case 2582: LAUNCH_KERNEL(2582); break;
	case 2583: LAUNCH_KERNEL(2583); break;
	case 2584: LAUNCH_KERNEL(2584); break;
	case 2585: LAUNCH_KERNEL(2585); break;
	case 2586: LAUNCH_KERNEL(2586); break;
	case 2587: LAUNCH_KERNEL(2587); break;
	case 2588: LAUNCH_KERNEL(2588); break;
	case 2589: LAUNCH_KERNEL(2589); break;
	case 2590: LAUNCH_KERNEL(2590); break;
	case 2591: LAUNCH_KERNEL(2591); break;
	case 2592: LAUNCH_KERNEL(2592); break;
	case 2593: LAUNCH_KERNEL(2593); break;
	case 2594: LAUNCH_KERNEL(2594); break;
	case 2595: LAUNCH_KERNEL(2595); break;
	case 2596: LAUNCH_KERNEL(2596); break;
	case 2597: LAUNCH_KERNEL(2597); break;
	case 2598: LAUNCH_KERNEL(2598); break;
	case 2599: LAUNCH_KERNEL(2599); break;
	case 2600: LAUNCH_KERNEL(2600); break;
	case 2601: LAUNCH_KERNEL(2601); break;
	case 2602: LAUNCH_KERNEL(2602); break;
	case 2603: LAUNCH_KERNEL(2603); break;
	case 2604: LAUNCH_KERNEL(2604); break;
	case 2605: LAUNCH_KERNEL(2605); break;
	case 2606: LAUNCH_KERNEL(2606); break;
	case 2607: LAUNCH_KERNEL(2607); break;
	case 2608: LAUNCH_KERNEL(2608); break;
	case 2609: LAUNCH_KERNEL(2609); break;
	case 2610: LAUNCH_KERNEL(2610); break;
	case 2611: LAUNCH_KERNEL(2611); break;
	case 2612: LAUNCH_KERNEL(2612); break;
	case 2613: LAUNCH_KERNEL(2613); break;
	case 2614: LAUNCH_KERNEL(2614); break;
	case 2615: LAUNCH_KERNEL(2615); break;
	case 2616: LAUNCH_KERNEL(2616); break;
	case 2617: LAUNCH_KERNEL(2617); break;
	case 2618: LAUNCH_KERNEL(2618); break;
	case 2619: LAUNCH_KERNEL(2619); break;
	case 2620: LAUNCH_KERNEL(2620); break;
	case 2621: LAUNCH_KERNEL(2621); break;
	case 2622: LAUNCH_KERNEL(2622); break;
	case 2623: LAUNCH_KERNEL(2623); break;
	case 2624: LAUNCH_KERNEL(2624); break;
	case 2625: LAUNCH_KERNEL(2625); break;
	case 2626: LAUNCH_KERNEL(2626); break;
	case 2627: LAUNCH_KERNEL(2627); break;
	case 2628: LAUNCH_KERNEL(2628); break;
	case 2629: LAUNCH_KERNEL(2629); break;
	case 2630: LAUNCH_KERNEL(2630); break;
	case 2631: LAUNCH_KERNEL(2631); break;
	case 2632: LAUNCH_KERNEL(2632); break;
	case 2633: LAUNCH_KERNEL(2633); break;
	case 2634: LAUNCH_KERNEL(2634); break;
	case 2635: LAUNCH_KERNEL(2635); break;
	case 2636: LAUNCH_KERNEL(2636); break;
	case 2637: LAUNCH_KERNEL(2637); break;
	case 2638: LAUNCH_KERNEL(2638); break;
	case 2639: LAUNCH_KERNEL(2639); break;
	case 2640: LAUNCH_KERNEL(2640); break;
	case 2641: LAUNCH_KERNEL(2641); break;
	case 2642: LAUNCH_KERNEL(2642); break;
	case 2643: LAUNCH_KERNEL(2643); break;
	case 2644: LAUNCH_KERNEL(2644); break;
	case 2645: LAUNCH_KERNEL(2645); break;
	case 2646: LAUNCH_KERNEL(2646); break;
	case 2647: LAUNCH_KERNEL(2647); break;
	case 2648: LAUNCH_KERNEL(2648); break;
	case 2649: LAUNCH_KERNEL(2649); break;
	case 2650: LAUNCH_KERNEL(2650); break;
	case 2651: LAUNCH_KERNEL(2651); break;
	case 2652: LAUNCH_KERNEL(2652); break;
	case 2653: LAUNCH_KERNEL(2653); break;
	case 2654: LAUNCH_KERNEL(2654); break;
	case 2655: LAUNCH_KERNEL(2655); break;
	case 2656: LAUNCH_KERNEL(2656); break;
	case 2657: LAUNCH_KERNEL(2657); break;
	case 2658: LAUNCH_KERNEL(2658); break;
	case 2659: LAUNCH_KERNEL(2659); break;
	case 2660: LAUNCH_KERNEL(2660); break;
	case 2661: LAUNCH_KERNEL(2661); break;
	case 2662: LAUNCH_KERNEL(2662); break;
	case 2663: LAUNCH_KERNEL(2663); break;
	case 2664: LAUNCH_KERNEL(2664); break;
	case 2665: LAUNCH_KERNEL(2665); break;
	case 2666: LAUNCH_KERNEL(2666); break;
	case 2667: LAUNCH_KERNEL(2667); break;
	case 2668: LAUNCH_KERNEL(2668); break;
	case 2669: LAUNCH_KERNEL(2669); break;
	case 2670: LAUNCH_KERNEL(2670); break;
	case 2671: LAUNCH_KERNEL(2671); break;
	case 2672: LAUNCH_KERNEL(2672); break;
	case 2673: LAUNCH_KERNEL(2673); break;
	case 2674: LAUNCH_KERNEL(2674); break;
	case 2675: LAUNCH_KERNEL(2675); break;
	case 2676: LAUNCH_KERNEL(2676); break;
	case 2677: LAUNCH_KERNEL(2677); break;
	case 2678: LAUNCH_KERNEL(2678); break;
	case 2679: LAUNCH_KERNEL(2679); break;
	case 2680: LAUNCH_KERNEL(2680); break;
	case 2681: LAUNCH_KERNEL(2681); break;
	case 2682: LAUNCH_KERNEL(2682); break;
	case 2683: LAUNCH_KERNEL(2683); break;
	case 2684: LAUNCH_KERNEL(2684); break;
	case 2685: LAUNCH_KERNEL(2685); break;
	case 2686: LAUNCH_KERNEL(2686); break;
	case 2687: LAUNCH_KERNEL(2687); break;
	case 2688: LAUNCH_KERNEL(2688); break;
	case 2689: LAUNCH_KERNEL(2689); break;
	case 2690: LAUNCH_KERNEL(2690); break;
	case 2691: LAUNCH_KERNEL(2691); break;
	case 2692: LAUNCH_KERNEL(2692); break;
	case 2693: LAUNCH_KERNEL(2693); break;
	case 2694: LAUNCH_KERNEL(2694); break;
	case 2695: LAUNCH_KERNEL(2695); break;
	case 2696: LAUNCH_KERNEL(2696); break;
	case 2697: LAUNCH_KERNEL(2697); break;
	case 2698: LAUNCH_KERNEL(2698); break;
	case 2699: LAUNCH_KERNEL(2699); break;
	case 2700: LAUNCH_KERNEL(2700); break;
	case 2701: LAUNCH_KERNEL(2701); break;
	case 2702: LAUNCH_KERNEL(2702); break;
	case 2703: LAUNCH_KERNEL(2703); break;
	case 2704: LAUNCH_KERNEL(2704); break;
	case 2705: LAUNCH_KERNEL(2705); break;
	case 2706: LAUNCH_KERNEL(2706); break;
	case 2707: LAUNCH_KERNEL(2707); break;
	case 2708: LAUNCH_KERNEL(2708); break;
	case 2709: LAUNCH_KERNEL(2709); break;
	case 2710: LAUNCH_KERNEL(2710); break;
	case 2711: LAUNCH_KERNEL(2711); break;
	case 2712: LAUNCH_KERNEL(2712); break;
	case 2713: LAUNCH_KERNEL(2713); break;
	case 2714: LAUNCH_KERNEL(2714); break;
	case 2715: LAUNCH_KERNEL(2715); break;
	case 2716: LAUNCH_KERNEL(2716); break;
	case 2717: LAUNCH_KERNEL(2717); break;
	case 2718: LAUNCH_KERNEL(2718); break;
	case 2719: LAUNCH_KERNEL(2719); break;
	case 2720: LAUNCH_KERNEL(2720); break;
	case 2721: LAUNCH_KERNEL(2721); break;
	case 2722: LAUNCH_KERNEL(2722); break;
	case 2723: LAUNCH_KERNEL(2723); break;
	case 2724: LAUNCH_KERNEL(2724); break;
	case 2725: LAUNCH_KERNEL(2725); break;
	case 2726: LAUNCH_KERNEL(2726); break;
	case 2727: LAUNCH_KERNEL(2727); break;
	case 2728: LAUNCH_KERNEL(2728); break;
	case 2729: LAUNCH_KERNEL(2729); break;
	case 2730: LAUNCH_KERNEL(2730); break;
	case 2731: LAUNCH_KERNEL(2731); break;
	case 2732: LAUNCH_KERNEL(2732); break;
	case 2733: LAUNCH_KERNEL(2733); break;
	case 2734: LAUNCH_KERNEL(2734); break;
	case 2735: LAUNCH_KERNEL(2735); break;
	case 2736: LAUNCH_KERNEL(2736); break;
	case 2737: LAUNCH_KERNEL(2737); break;
	case 2738: LAUNCH_KERNEL(2738); break;
	case 2739: LAUNCH_KERNEL(2739); break;
	case 2740: LAUNCH_KERNEL(2740); break;
	case 2741: LAUNCH_KERNEL(2741); break;
	case 2742: LAUNCH_KERNEL(2742); break;
	case 2743: LAUNCH_KERNEL(2743); break;
	case 2744: LAUNCH_KERNEL(2744); break;
	case 2745: LAUNCH_KERNEL(2745); break;
	case 2746: LAUNCH_KERNEL(2746); break;
	case 2747: LAUNCH_KERNEL(2747); break;
	case 2748: LAUNCH_KERNEL(2748); break;
	case 2749: LAUNCH_KERNEL(2749); break;
	case 2750: LAUNCH_KERNEL(2750); break;
	case 2751: LAUNCH_KERNEL(2751); break;
	case 2752: LAUNCH_KERNEL(2752); break;
	case 2753: LAUNCH_KERNEL(2753); break;
	case 2754: LAUNCH_KERNEL(2754); break;
	case 2755: LAUNCH_KERNEL(2755); break;
	case 2756: LAUNCH_KERNEL(2756); break;
	case 2757: LAUNCH_KERNEL(2757); break;
	case 2758: LAUNCH_KERNEL(2758); break;
	case 2759: LAUNCH_KERNEL(2759); break;
	case 2760: LAUNCH_KERNEL(2760); break;
	case 2761: LAUNCH_KERNEL(2761); break;
	case 2762: LAUNCH_KERNEL(2762); break;
	case 2763: LAUNCH_KERNEL(2763); break;
	case 2764: LAUNCH_KERNEL(2764); break;
	case 2765: LAUNCH_KERNEL(2765); break;
	case 2766: LAUNCH_KERNEL(2766); break;
	case 2767: LAUNCH_KERNEL(2767); break;
	case 2768: LAUNCH_KERNEL(2768); break;
	case 2769: LAUNCH_KERNEL(2769); break;
	case 2770: LAUNCH_KERNEL(2770); break;
	case 2771: LAUNCH_KERNEL(2771); break;
	case 2772: LAUNCH_KERNEL(2772); break;
	case 2773: LAUNCH_KERNEL(2773); break;
	case 2774: LAUNCH_KERNEL(2774); break;
	case 2775: LAUNCH_KERNEL(2775); break;
	case 2776: LAUNCH_KERNEL(2776); break;
	case 2777: LAUNCH_KERNEL(2777); break;
	case 2778: LAUNCH_KERNEL(2778); break;
	case 2779: LAUNCH_KERNEL(2779); break;
	case 2780: LAUNCH_KERNEL(2780); break;
	case 2781: LAUNCH_KERNEL(2781); break;
	case 2782: LAUNCH_KERNEL(2782); break;
	case 2783: LAUNCH_KERNEL(2783); break;
	case 2784: LAUNCH_KERNEL(2784); break;
	case 2785: LAUNCH_KERNEL(2785); break;
	case 2786: LAUNCH_KERNEL(2786); break;
	case 2787: LAUNCH_KERNEL(2787); break;
	case 2788: LAUNCH_KERNEL(2788); break;
	case 2789: LAUNCH_KERNEL(2789); break;
	case 2790: LAUNCH_KERNEL(2790); break;
	case 2791: LAUNCH_KERNEL(2791); break;
	case 2792: LAUNCH_KERNEL(2792); break;
	case 2793: LAUNCH_KERNEL(2793); break;
	case 2794: LAUNCH_KERNEL(2794); break;
	case 2795: LAUNCH_KERNEL(2795); break;
	case 2796: LAUNCH_KERNEL(2796); break;
	case 2797: LAUNCH_KERNEL(2797); break;
	case 2798: LAUNCH_KERNEL(2798); break;
	case 2799: LAUNCH_KERNEL(2799); break;
	case 2800: LAUNCH_KERNEL(2800); break;
	case 2801: LAUNCH_KERNEL(2801); break;
	case 2802: LAUNCH_KERNEL(2802); break;
	case 2803: LAUNCH_KERNEL(2803); break;
	case 2804: LAUNCH_KERNEL(2804); break;
	case 2805: LAUNCH_KERNEL(2805); break;
	case 2806: LAUNCH_KERNEL(2806); break;
	case 2807: LAUNCH_KERNEL(2807); break;
	case 2808: LAUNCH_KERNEL(2808); break;
	case 2809: LAUNCH_KERNEL(2809); break;
	case 2810: LAUNCH_KERNEL(2810); break;
	case 2811: LAUNCH_KERNEL(2811); break;
	case 2812: LAUNCH_KERNEL(2812); break;
	case 2813: LAUNCH_KERNEL(2813); break;
	case 2814: LAUNCH_KERNEL(2814); break;
	case 2815: LAUNCH_KERNEL(2815); break;
	case 2816: LAUNCH_KERNEL(2816); break;
	case 2817: LAUNCH_KERNEL(2817); break;
	case 2818: LAUNCH_KERNEL(2818); break;
	case 2819: LAUNCH_KERNEL(2819); break;
	case 2820: LAUNCH_KERNEL(2820); break;
	case 2821: LAUNCH_KERNEL(2821); break;
	case 2822: LAUNCH_KERNEL(2822); break;
	case 2823: LAUNCH_KERNEL(2823); break;
	case 2824: LAUNCH_KERNEL(2824); break;
	case 2825: LAUNCH_KERNEL(2825); break;
	case 2826: LAUNCH_KERNEL(2826); break;
	case 2827: LAUNCH_KERNEL(2827); break;
	case 2828: LAUNCH_KERNEL(2828); break;
	case 2829: LAUNCH_KERNEL(2829); break;
	case 2830: LAUNCH_KERNEL(2830); break;
	case 2831: LAUNCH_KERNEL(2831); break;
	case 2832: LAUNCH_KERNEL(2832); break;
	case 2833: LAUNCH_KERNEL(2833); break;
	case 2834: LAUNCH_KERNEL(2834); break;
	case 2835: LAUNCH_KERNEL(2835); break;
	case 2836: LAUNCH_KERNEL(2836); break;
	case 2837: LAUNCH_KERNEL(2837); break;
	case 2838: LAUNCH_KERNEL(2838); break;
	case 2839: LAUNCH_KERNEL(2839); break;
	case 2840: LAUNCH_KERNEL(2840); break;
	case 2841: LAUNCH_KERNEL(2841); break;
	case 2842: LAUNCH_KERNEL(2842); break;
	case 2843: LAUNCH_KERNEL(2843); break;
	case 2844: LAUNCH_KERNEL(2844); break;
	case 2845: LAUNCH_KERNEL(2845); break;
	case 2846: LAUNCH_KERNEL(2846); break;
	case 2847: LAUNCH_KERNEL(2847); break;
	case 2848: LAUNCH_KERNEL(2848); break;
	case 2849: LAUNCH_KERNEL(2849); break;
	case 2850: LAUNCH_KERNEL(2850); break;
	case 2851: LAUNCH_KERNEL(2851); break;
	case 2852: LAUNCH_KERNEL(2852); break;
	case 2853: LAUNCH_KERNEL(2853); break;
	case 2854: LAUNCH_KERNEL(2854); break;
	case 2855: LAUNCH_KERNEL(2855); break;
	case 2856: LAUNCH_KERNEL(2856); break;
	case 2857: LAUNCH_KERNEL(2857); break;
	case 2858: LAUNCH_KERNEL(2858); break;
	case 2859: LAUNCH_KERNEL(2859); break;
	case 2860: LAUNCH_KERNEL(2860); break;
	case 2861: LAUNCH_KERNEL(2861); break;
	case 2862: LAUNCH_KERNEL(2862); break;
	case 2863: LAUNCH_KERNEL(2863); break;
	case 2864: LAUNCH_KERNEL(2864); break;
	case 2865: LAUNCH_KERNEL(2865); break;
	case 2866: LAUNCH_KERNEL(2866); break;
	case 2867: LAUNCH_KERNEL(2867); break;
	case 2868: LAUNCH_KERNEL(2868); break;
	case 2869: LAUNCH_KERNEL(2869); break;
	case 2870: LAUNCH_KERNEL(2870); break;
	case 2871: LAUNCH_KERNEL(2871); break;
	case 2872: LAUNCH_KERNEL(2872); break;
	case 2873: LAUNCH_KERNEL(2873); break;
	case 2874: LAUNCH_KERNEL(2874); break;
	case 2875: LAUNCH_KERNEL(2875); break;
	case 2876: LAUNCH_KERNEL(2876); break;
	case 2877: LAUNCH_KERNEL(2877); break;
	case 2878: LAUNCH_KERNEL(2878); break;
	case 2879: LAUNCH_KERNEL(2879); break;
	case 2880: LAUNCH_KERNEL(2880); break;
	case 2881: LAUNCH_KERNEL(2881); break;
	case 2882: LAUNCH_KERNEL(2882); break;
	case 2883: LAUNCH_KERNEL(2883); break;
	case 2884: LAUNCH_KERNEL(2884); break;
	case 2885: LAUNCH_KERNEL(2885); break;
	case 2886: LAUNCH_KERNEL(2886); break;
	case 2887: LAUNCH_KERNEL(2887); break;
	case 2888: LAUNCH_KERNEL(2888); break;
	case 2889: LAUNCH_KERNEL(2889); break;
	case 2890: LAUNCH_KERNEL(2890); break;
	case 2891: LAUNCH_KERNEL(2891); break;
	case 2892: LAUNCH_KERNEL(2892); break;
	case 2893: LAUNCH_KERNEL(2893); break;
	case 2894: LAUNCH_KERNEL(2894); break;
	case 2895: LAUNCH_KERNEL(2895); break;
	case 2896: LAUNCH_KERNEL(2896); break;
	case 2897: LAUNCH_KERNEL(2897); break;
	case 2898: LAUNCH_KERNEL(2898); break;
	case 2899: LAUNCH_KERNEL(2899); break;
	case 2900: LAUNCH_KERNEL(2900); break;
	case 2901: LAUNCH_KERNEL(2901); break;
	case 2902: LAUNCH_KERNEL(2902); break;
	case 2903: LAUNCH_KERNEL(2903); break;
	case 2904: LAUNCH_KERNEL(2904); break;
	case 2905: LAUNCH_KERNEL(2905); break;
	case 2906: LAUNCH_KERNEL(2906); break;
	case 2907: LAUNCH_KERNEL(2907); break;
	case 2908: LAUNCH_KERNEL(2908); break;
	case 2909: LAUNCH_KERNEL(2909); break;
	case 2910: LAUNCH_KERNEL(2910); break;
	case 2911: LAUNCH_KERNEL(2911); break;
	case 2912: LAUNCH_KERNEL(2912); break;
	case 2913: LAUNCH_KERNEL(2913); break;
	case 2914: LAUNCH_KERNEL(2914); break;
	case 2915: LAUNCH_KERNEL(2915); break;
	case 2916: LAUNCH_KERNEL(2916); break;
	case 2917: LAUNCH_KERNEL(2917); break;
	case 2918: LAUNCH_KERNEL(2918); break;
	case 2919: LAUNCH_KERNEL(2919); break;
	case 2920: LAUNCH_KERNEL(2920); break;
	case 2921: LAUNCH_KERNEL(2921); break;
	case 2922: LAUNCH_KERNEL(2922); break;
	case 2923: LAUNCH_KERNEL(2923); break;
	case 2924: LAUNCH_KERNEL(2924); break;
	case 2925: LAUNCH_KERNEL(2925); break;
	case 2926: LAUNCH_KERNEL(2926); break;
	case 2927: LAUNCH_KERNEL(2927); break;
	case 2928: LAUNCH_KERNEL(2928); break;
	case 2929: LAUNCH_KERNEL(2929); break;
	case 2930: LAUNCH_KERNEL(2930); break;
	case 2931: LAUNCH_KERNEL(2931); break;
	case 2932: LAUNCH_KERNEL(2932); break;
	case 2933: LAUNCH_KERNEL(2933); break;
	case 2934: LAUNCH_KERNEL(2934); break;
	case 2935: LAUNCH_KERNEL(2935); break;
	case 2936: LAUNCH_KERNEL(2936); break;
	case 2937: LAUNCH_KERNEL(2937); break;
	case 2938: LAUNCH_KERNEL(2938); break;
	case 2939: LAUNCH_KERNEL(2939); break;
	case 2940: LAUNCH_KERNEL(2940); break;
	case 2941: LAUNCH_KERNEL(2941); break;
	case 2942: LAUNCH_KERNEL(2942); break;
	case 2943: LAUNCH_KERNEL(2943); break;
	case 2944: LAUNCH_KERNEL(2944); break;
	case 2945: LAUNCH_KERNEL(2945); break;
	case 2946: LAUNCH_KERNEL(2946); break;
	case 2947: LAUNCH_KERNEL(2947); break;
	case 2948: LAUNCH_KERNEL(2948); break;
	case 2949: LAUNCH_KERNEL(2949); break;
	case 2950: LAUNCH_KERNEL(2950); break;
	case 2951: LAUNCH_KERNEL(2951); break;
	case 2952: LAUNCH_KERNEL(2952); break;
	case 2953: LAUNCH_KERNEL(2953); break;
	case 2954: LAUNCH_KERNEL(2954); break;
	case 2955: LAUNCH_KERNEL(2955); break;
	case 2956: LAUNCH_KERNEL(2956); break;
	case 2957: LAUNCH_KERNEL(2957); break;
	case 2958: LAUNCH_KERNEL(2958); break;
	case 2959: LAUNCH_KERNEL(2959); break;
	case 2960: LAUNCH_KERNEL(2960); break;
	case 2961: LAUNCH_KERNEL(2961); break;
	case 2962: LAUNCH_KERNEL(2962); break;
	case 2963: LAUNCH_KERNEL(2963); break;
	case 2964: LAUNCH_KERNEL(2964); break;
	case 2965: LAUNCH_KERNEL(2965); break;
	case 2966: LAUNCH_KERNEL(2966); break;
	case 2967: LAUNCH_KERNEL(2967); break;
	case 2968: LAUNCH_KERNEL(2968); break;
	case 2969: LAUNCH_KERNEL(2969); break;
	case 2970: LAUNCH_KERNEL(2970); break;
	case 2971: LAUNCH_KERNEL(2971); break;
	case 2972: LAUNCH_KERNEL(2972); break;
	case 2973: LAUNCH_KERNEL(2973); break;
	case 2974: LAUNCH_KERNEL(2974); break;
	case 2975: LAUNCH_KERNEL(2975); break;
	case 2976: LAUNCH_KERNEL(2976); break;
	case 2977: LAUNCH_KERNEL(2977); break;
	case 2978: LAUNCH_KERNEL(2978); break;
	case 2979: LAUNCH_KERNEL(2979); break;
	case 2980: LAUNCH_KERNEL(2980); break;
	case 2981: LAUNCH_KERNEL(2981); break;
	case 2982: LAUNCH_KERNEL(2982); break;
	case 2983: LAUNCH_KERNEL(2983); break;
	case 2984: LAUNCH_KERNEL(2984); break;
	case 2985: LAUNCH_KERNEL(2985); break;
	case 2986: LAUNCH_KERNEL(2986); break;
	case 2987: LAUNCH_KERNEL(2987); break;
	case 2988: LAUNCH_KERNEL(2988); break;
	case 2989: LAUNCH_KERNEL(2989); break;
	case 2990: LAUNCH_KERNEL(2990); break;
	case 2991: LAUNCH_KERNEL(2991); break;
	case 2992: LAUNCH_KERNEL(2992); break;
	case 2993: LAUNCH_KERNEL(2993); break;
	case 2994: LAUNCH_KERNEL(2994); break;
	case 2995: LAUNCH_KERNEL(2995); break;
	case 2996: LAUNCH_KERNEL(2996); break;
	case 2997: LAUNCH_KERNEL(2997); break;
	case 2998: LAUNCH_KERNEL(2998); break;
	case 2999: LAUNCH_KERNEL(2999); break;
	case 3000: LAUNCH_KERNEL(3000); break;
	case 3001: LAUNCH_KERNEL(3001); break;
	case 3002: LAUNCH_KERNEL(3002); break;
	case 3003: LAUNCH_KERNEL(3003); break;
	case 3004: LAUNCH_KERNEL(3004); break;
	case 3005: LAUNCH_KERNEL(3005); break;
	case 3006: LAUNCH_KERNEL(3006); break;
	case 3007: LAUNCH_KERNEL(3007); break;
	case 3008: LAUNCH_KERNEL(3008); break;
	case 3009: LAUNCH_KERNEL(3009); break;
	case 3010: LAUNCH_KERNEL(3010); break;
	case 3011: LAUNCH_KERNEL(3011); break;
	case 3012: LAUNCH_KERNEL(3012); break;
	case 3013: LAUNCH_KERNEL(3013); break;
	case 3014: LAUNCH_KERNEL(3014); break;
	case 3015: LAUNCH_KERNEL(3015); break;
	case 3016: LAUNCH_KERNEL(3016); break;
	case 3017: LAUNCH_KERNEL(3017); break;
	case 3018: LAUNCH_KERNEL(3018); break;
	case 3019: LAUNCH_KERNEL(3019); break;
	case 3020: LAUNCH_KERNEL(3020); break;
	case 3021: LAUNCH_KERNEL(3021); break;
	case 3022: LAUNCH_KERNEL(3022); break;
	case 3023: LAUNCH_KERNEL(3023); break;
	case 3024: LAUNCH_KERNEL(3024); break;
	case 3025: LAUNCH_KERNEL(3025); break;
	case 3026: LAUNCH_KERNEL(3026); break;
	case 3027: LAUNCH_KERNEL(3027); break;
	case 3028: LAUNCH_KERNEL(3028); break;
	case 3029: LAUNCH_KERNEL(3029); break;
	case 3030: LAUNCH_KERNEL(3030); break;
	case 3031: LAUNCH_KERNEL(3031); break;
	case 3032: LAUNCH_KERNEL(3032); break;
	case 3033: LAUNCH_KERNEL(3033); break;
	case 3034: LAUNCH_KERNEL(3034); break;
	case 3035: LAUNCH_KERNEL(3035); break;
	case 3036: LAUNCH_KERNEL(3036); break;
	case 3037: LAUNCH_KERNEL(3037); break;
	case 3038: LAUNCH_KERNEL(3038); break;
	case 3039: LAUNCH_KERNEL(3039); break;
	case 3040: LAUNCH_KERNEL(3040); break;
	case 3041: LAUNCH_KERNEL(3041); break;
	case 3042: LAUNCH_KERNEL(3042); break;
	case 3043: LAUNCH_KERNEL(3043); break;
	case 3044: LAUNCH_KERNEL(3044); break;
	case 3045: LAUNCH_KERNEL(3045); break;
	case 3046: LAUNCH_KERNEL(3046); break;
	case 3047: LAUNCH_KERNEL(3047); break;
	case 3048: LAUNCH_KERNEL(3048); break;
	case 3049: LAUNCH_KERNEL(3049); break;
	case 3050: LAUNCH_KERNEL(3050); break;
	case 3051: LAUNCH_KERNEL(3051); break;
	case 3052: LAUNCH_KERNEL(3052); break;
	case 3053: LAUNCH_KERNEL(3053); break;
	case 3054: LAUNCH_KERNEL(3054); break;
	case 3055: LAUNCH_KERNEL(3055); break;
	case 3056: LAUNCH_KERNEL(3056); break;
	case 3057: LAUNCH_KERNEL(3057); break;
	case 3058: LAUNCH_KERNEL(3058); break;
	case 3059: LAUNCH_KERNEL(3059); break;
	case 3060: LAUNCH_KERNEL(3060); break;
	case 3061: LAUNCH_KERNEL(3061); break;
	case 3062: LAUNCH_KERNEL(3062); break;
	case 3063: LAUNCH_KERNEL(3063); break;
	case 3064: LAUNCH_KERNEL(3064); break;
	case 3065: LAUNCH_KERNEL(3065); break;
	case 3066: LAUNCH_KERNEL(3066); break;
	case 3067: LAUNCH_KERNEL(3067); break;
	case 3068: LAUNCH_KERNEL(3068); break;
	case 3069: LAUNCH_KERNEL(3069); break;
	case 3070: LAUNCH_KERNEL(3070); break;
	case 3071: LAUNCH_KERNEL(3071); break;
	default: printf("intSalt: %d\n", intSalt); ASSERT(FALSE);
	}
}

#endif
