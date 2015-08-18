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

#define SALT 1536
#include "CUDA10_Registers_Kernel.h"
#define SALT 1537
#include "CUDA10_Registers_Kernel.h"
#define SALT 1538
#include "CUDA10_Registers_Kernel.h"
#define SALT 1539
#include "CUDA10_Registers_Kernel.h"
#define SALT 1540
#include "CUDA10_Registers_Kernel.h"
#define SALT 1541
#include "CUDA10_Registers_Kernel.h"
#define SALT 1542
#include "CUDA10_Registers_Kernel.h"
#define SALT 1543
#include "CUDA10_Registers_Kernel.h"
#define SALT 1544
#include "CUDA10_Registers_Kernel.h"
#define SALT 1545
#include "CUDA10_Registers_Kernel.h"
#define SALT 1546
#include "CUDA10_Registers_Kernel.h"
#define SALT 1547
#include "CUDA10_Registers_Kernel.h"
#define SALT 1548
#include "CUDA10_Registers_Kernel.h"
#define SALT 1549
#include "CUDA10_Registers_Kernel.h"
#define SALT 1550
#include "CUDA10_Registers_Kernel.h"
#define SALT 1551
#include "CUDA10_Registers_Kernel.h"
#define SALT 1552
#include "CUDA10_Registers_Kernel.h"
#define SALT 1553
#include "CUDA10_Registers_Kernel.h"
#define SALT 1554
#include "CUDA10_Registers_Kernel.h"
#define SALT 1555
#include "CUDA10_Registers_Kernel.h"
#define SALT 1556
#include "CUDA10_Registers_Kernel.h"
#define SALT 1557
#include "CUDA10_Registers_Kernel.h"
#define SALT 1558
#include "CUDA10_Registers_Kernel.h"
#define SALT 1559
#include "CUDA10_Registers_Kernel.h"
#define SALT 1560
#include "CUDA10_Registers_Kernel.h"
#define SALT 1561
#include "CUDA10_Registers_Kernel.h"
#define SALT 1562
#include "CUDA10_Registers_Kernel.h"
#define SALT 1563
#include "CUDA10_Registers_Kernel.h"
#define SALT 1564
#include "CUDA10_Registers_Kernel.h"
#define SALT 1565
#include "CUDA10_Registers_Kernel.h"
#define SALT 1566
#include "CUDA10_Registers_Kernel.h"
#define SALT 1567
#include "CUDA10_Registers_Kernel.h"
#define SALT 1568
#include "CUDA10_Registers_Kernel.h"
#define SALT 1569
#include "CUDA10_Registers_Kernel.h"
#define SALT 1570
#include "CUDA10_Registers_Kernel.h"
#define SALT 1571
#include "CUDA10_Registers_Kernel.h"
#define SALT 1572
#include "CUDA10_Registers_Kernel.h"
#define SALT 1573
#include "CUDA10_Registers_Kernel.h"
#define SALT 1574
#include "CUDA10_Registers_Kernel.h"
#define SALT 1575
#include "CUDA10_Registers_Kernel.h"
#define SALT 1576
#include "CUDA10_Registers_Kernel.h"
#define SALT 1577
#include "CUDA10_Registers_Kernel.h"
#define SALT 1578
#include "CUDA10_Registers_Kernel.h"
#define SALT 1579
#include "CUDA10_Registers_Kernel.h"
#define SALT 1580
#include "CUDA10_Registers_Kernel.h"
#define SALT 1581
#include "CUDA10_Registers_Kernel.h"
#define SALT 1582
#include "CUDA10_Registers_Kernel.h"
#define SALT 1583
#include "CUDA10_Registers_Kernel.h"
#define SALT 1584
#include "CUDA10_Registers_Kernel.h"
#define SALT 1585
#include "CUDA10_Registers_Kernel.h"
#define SALT 1586
#include "CUDA10_Registers_Kernel.h"
#define SALT 1587
#include "CUDA10_Registers_Kernel.h"
#define SALT 1588
#include "CUDA10_Registers_Kernel.h"
#define SALT 1589
#include "CUDA10_Registers_Kernel.h"
#define SALT 1590
#include "CUDA10_Registers_Kernel.h"
#define SALT 1591
#include "CUDA10_Registers_Kernel.h"
#define SALT 1592
#include "CUDA10_Registers_Kernel.h"
#define SALT 1593
#include "CUDA10_Registers_Kernel.h"
#define SALT 1594
#include "CUDA10_Registers_Kernel.h"
#define SALT 1595
#include "CUDA10_Registers_Kernel.h"
#define SALT 1596
#include "CUDA10_Registers_Kernel.h"
#define SALT 1597
#include "CUDA10_Registers_Kernel.h"
#define SALT 1598
#include "CUDA10_Registers_Kernel.h"
#define SALT 1599
#include "CUDA10_Registers_Kernel.h"
#define SALT 1600
#include "CUDA10_Registers_Kernel.h"
#define SALT 1601
#include "CUDA10_Registers_Kernel.h"
#define SALT 1602
#include "CUDA10_Registers_Kernel.h"
#define SALT 1603
#include "CUDA10_Registers_Kernel.h"
#define SALT 1604
#include "CUDA10_Registers_Kernel.h"
#define SALT 1605
#include "CUDA10_Registers_Kernel.h"
#define SALT 1606
#include "CUDA10_Registers_Kernel.h"
#define SALT 1607
#include "CUDA10_Registers_Kernel.h"
#define SALT 1608
#include "CUDA10_Registers_Kernel.h"
#define SALT 1609
#include "CUDA10_Registers_Kernel.h"
#define SALT 1610
#include "CUDA10_Registers_Kernel.h"
#define SALT 1611
#include "CUDA10_Registers_Kernel.h"
#define SALT 1612
#include "CUDA10_Registers_Kernel.h"
#define SALT 1613
#include "CUDA10_Registers_Kernel.h"
#define SALT 1614
#include "CUDA10_Registers_Kernel.h"
#define SALT 1615
#include "CUDA10_Registers_Kernel.h"
#define SALT 1616
#include "CUDA10_Registers_Kernel.h"
#define SALT 1617
#include "CUDA10_Registers_Kernel.h"
#define SALT 1618
#include "CUDA10_Registers_Kernel.h"
#define SALT 1619
#include "CUDA10_Registers_Kernel.h"
#define SALT 1620
#include "CUDA10_Registers_Kernel.h"
#define SALT 1621
#include "CUDA10_Registers_Kernel.h"
#define SALT 1622
#include "CUDA10_Registers_Kernel.h"
#define SALT 1623
#include "CUDA10_Registers_Kernel.h"
#define SALT 1624
#include "CUDA10_Registers_Kernel.h"
#define SALT 1625
#include "CUDA10_Registers_Kernel.h"
#define SALT 1626
#include "CUDA10_Registers_Kernel.h"
#define SALT 1627
#include "CUDA10_Registers_Kernel.h"
#define SALT 1628
#include "CUDA10_Registers_Kernel.h"
#define SALT 1629
#include "CUDA10_Registers_Kernel.h"
#define SALT 1630
#include "CUDA10_Registers_Kernel.h"
#define SALT 1631
#include "CUDA10_Registers_Kernel.h"
#define SALT 1632
#include "CUDA10_Registers_Kernel.h"
#define SALT 1633
#include "CUDA10_Registers_Kernel.h"
#define SALT 1634
#include "CUDA10_Registers_Kernel.h"
#define SALT 1635
#include "CUDA10_Registers_Kernel.h"
#define SALT 1636
#include "CUDA10_Registers_Kernel.h"
#define SALT 1637
#include "CUDA10_Registers_Kernel.h"
#define SALT 1638
#include "CUDA10_Registers_Kernel.h"
#define SALT 1639
#include "CUDA10_Registers_Kernel.h"
#define SALT 1640
#include "CUDA10_Registers_Kernel.h"
#define SALT 1641
#include "CUDA10_Registers_Kernel.h"
#define SALT 1642
#include "CUDA10_Registers_Kernel.h"
#define SALT 1643
#include "CUDA10_Registers_Kernel.h"
#define SALT 1644
#include "CUDA10_Registers_Kernel.h"
#define SALT 1645
#include "CUDA10_Registers_Kernel.h"
#define SALT 1646
#include "CUDA10_Registers_Kernel.h"
#define SALT 1647
#include "CUDA10_Registers_Kernel.h"
#define SALT 1648
#include "CUDA10_Registers_Kernel.h"
#define SALT 1649
#include "CUDA10_Registers_Kernel.h"
#define SALT 1650
#include "CUDA10_Registers_Kernel.h"
#define SALT 1651
#include "CUDA10_Registers_Kernel.h"
#define SALT 1652
#include "CUDA10_Registers_Kernel.h"
#define SALT 1653
#include "CUDA10_Registers_Kernel.h"
#define SALT 1654
#include "CUDA10_Registers_Kernel.h"
#define SALT 1655
#include "CUDA10_Registers_Kernel.h"
#define SALT 1656
#include "CUDA10_Registers_Kernel.h"
#define SALT 1657
#include "CUDA10_Registers_Kernel.h"
#define SALT 1658
#include "CUDA10_Registers_Kernel.h"
#define SALT 1659
#include "CUDA10_Registers_Kernel.h"
#define SALT 1660
#include "CUDA10_Registers_Kernel.h"
#define SALT 1661
#include "CUDA10_Registers_Kernel.h"
#define SALT 1662
#include "CUDA10_Registers_Kernel.h"
#define SALT 1663
#include "CUDA10_Registers_Kernel.h"
#define SALT 1664
#include "CUDA10_Registers_Kernel.h"
#define SALT 1665
#include "CUDA10_Registers_Kernel.h"
#define SALT 1666
#include "CUDA10_Registers_Kernel.h"
#define SALT 1667
#include "CUDA10_Registers_Kernel.h"
#define SALT 1668
#include "CUDA10_Registers_Kernel.h"
#define SALT 1669
#include "CUDA10_Registers_Kernel.h"
#define SALT 1670
#include "CUDA10_Registers_Kernel.h"
#define SALT 1671
#include "CUDA10_Registers_Kernel.h"
#define SALT 1672
#include "CUDA10_Registers_Kernel.h"
#define SALT 1673
#include "CUDA10_Registers_Kernel.h"
#define SALT 1674
#include "CUDA10_Registers_Kernel.h"
#define SALT 1675
#include "CUDA10_Registers_Kernel.h"
#define SALT 1676
#include "CUDA10_Registers_Kernel.h"
#define SALT 1677
#include "CUDA10_Registers_Kernel.h"
#define SALT 1678
#include "CUDA10_Registers_Kernel.h"
#define SALT 1679
#include "CUDA10_Registers_Kernel.h"
#define SALT 1680
#include "CUDA10_Registers_Kernel.h"
#define SALT 1681
#include "CUDA10_Registers_Kernel.h"
#define SALT 1682
#include "CUDA10_Registers_Kernel.h"
#define SALT 1683
#include "CUDA10_Registers_Kernel.h"
#define SALT 1684
#include "CUDA10_Registers_Kernel.h"
#define SALT 1685
#include "CUDA10_Registers_Kernel.h"
#define SALT 1686
#include "CUDA10_Registers_Kernel.h"
#define SALT 1687
#include "CUDA10_Registers_Kernel.h"
#define SALT 1688
#include "CUDA10_Registers_Kernel.h"
#define SALT 1689
#include "CUDA10_Registers_Kernel.h"
#define SALT 1690
#include "CUDA10_Registers_Kernel.h"
#define SALT 1691
#include "CUDA10_Registers_Kernel.h"
#define SALT 1692
#include "CUDA10_Registers_Kernel.h"
#define SALT 1693
#include "CUDA10_Registers_Kernel.h"
#define SALT 1694
#include "CUDA10_Registers_Kernel.h"
#define SALT 1695
#include "CUDA10_Registers_Kernel.h"
#define SALT 1696
#include "CUDA10_Registers_Kernel.h"
#define SALT 1697
#include "CUDA10_Registers_Kernel.h"
#define SALT 1698
#include "CUDA10_Registers_Kernel.h"
#define SALT 1699
#include "CUDA10_Registers_Kernel.h"
#define SALT 1700
#include "CUDA10_Registers_Kernel.h"
#define SALT 1701
#include "CUDA10_Registers_Kernel.h"
#define SALT 1702
#include "CUDA10_Registers_Kernel.h"
#define SALT 1703
#include "CUDA10_Registers_Kernel.h"
#define SALT 1704
#include "CUDA10_Registers_Kernel.h"
#define SALT 1705
#include "CUDA10_Registers_Kernel.h"
#define SALT 1706
#include "CUDA10_Registers_Kernel.h"
#define SALT 1707
#include "CUDA10_Registers_Kernel.h"
#define SALT 1708
#include "CUDA10_Registers_Kernel.h"
#define SALT 1709
#include "CUDA10_Registers_Kernel.h"
#define SALT 1710
#include "CUDA10_Registers_Kernel.h"
#define SALT 1711
#include "CUDA10_Registers_Kernel.h"
#define SALT 1712
#include "CUDA10_Registers_Kernel.h"
#define SALT 1713
#include "CUDA10_Registers_Kernel.h"
#define SALT 1714
#include "CUDA10_Registers_Kernel.h"
#define SALT 1715
#include "CUDA10_Registers_Kernel.h"
#define SALT 1716
#include "CUDA10_Registers_Kernel.h"
#define SALT 1717
#include "CUDA10_Registers_Kernel.h"
#define SALT 1718
#include "CUDA10_Registers_Kernel.h"
#define SALT 1719
#include "CUDA10_Registers_Kernel.h"
#define SALT 1720
#include "CUDA10_Registers_Kernel.h"
#define SALT 1721
#include "CUDA10_Registers_Kernel.h"
#define SALT 1722
#include "CUDA10_Registers_Kernel.h"
#define SALT 1723
#include "CUDA10_Registers_Kernel.h"
#define SALT 1724
#include "CUDA10_Registers_Kernel.h"
#define SALT 1725
#include "CUDA10_Registers_Kernel.h"
#define SALT 1726
#include "CUDA10_Registers_Kernel.h"
#define SALT 1727
#include "CUDA10_Registers_Kernel.h"
#define SALT 1728
#include "CUDA10_Registers_Kernel.h"
#define SALT 1729
#include "CUDA10_Registers_Kernel.h"
#define SALT 1730
#include "CUDA10_Registers_Kernel.h"
#define SALT 1731
#include "CUDA10_Registers_Kernel.h"
#define SALT 1732
#include "CUDA10_Registers_Kernel.h"
#define SALT 1733
#include "CUDA10_Registers_Kernel.h"
#define SALT 1734
#include "CUDA10_Registers_Kernel.h"
#define SALT 1735
#include "CUDA10_Registers_Kernel.h"
#define SALT 1736
#include "CUDA10_Registers_Kernel.h"
#define SALT 1737
#include "CUDA10_Registers_Kernel.h"
#define SALT 1738
#include "CUDA10_Registers_Kernel.h"
#define SALT 1739
#include "CUDA10_Registers_Kernel.h"
#define SALT 1740
#include "CUDA10_Registers_Kernel.h"
#define SALT 1741
#include "CUDA10_Registers_Kernel.h"
#define SALT 1742
#include "CUDA10_Registers_Kernel.h"
#define SALT 1743
#include "CUDA10_Registers_Kernel.h"
#define SALT 1744
#include "CUDA10_Registers_Kernel.h"
#define SALT 1745
#include "CUDA10_Registers_Kernel.h"
#define SALT 1746
#include "CUDA10_Registers_Kernel.h"
#define SALT 1747
#include "CUDA10_Registers_Kernel.h"
#define SALT 1748
#include "CUDA10_Registers_Kernel.h"
#define SALT 1749
#include "CUDA10_Registers_Kernel.h"
#define SALT 1750
#include "CUDA10_Registers_Kernel.h"
#define SALT 1751
#include "CUDA10_Registers_Kernel.h"
#define SALT 1752
#include "CUDA10_Registers_Kernel.h"
#define SALT 1753
#include "CUDA10_Registers_Kernel.h"
#define SALT 1754
#include "CUDA10_Registers_Kernel.h"
#define SALT 1755
#include "CUDA10_Registers_Kernel.h"
#define SALT 1756
#include "CUDA10_Registers_Kernel.h"
#define SALT 1757
#include "CUDA10_Registers_Kernel.h"
#define SALT 1758
#include "CUDA10_Registers_Kernel.h"
#define SALT 1759
#include "CUDA10_Registers_Kernel.h"
#define SALT 1760
#include "CUDA10_Registers_Kernel.h"
#define SALT 1761
#include "CUDA10_Registers_Kernel.h"
#define SALT 1762
#include "CUDA10_Registers_Kernel.h"
#define SALT 1763
#include "CUDA10_Registers_Kernel.h"
#define SALT 1764
#include "CUDA10_Registers_Kernel.h"
#define SALT 1765
#include "CUDA10_Registers_Kernel.h"
#define SALT 1766
#include "CUDA10_Registers_Kernel.h"
#define SALT 1767
#include "CUDA10_Registers_Kernel.h"
#define SALT 1768
#include "CUDA10_Registers_Kernel.h"
#define SALT 1769
#include "CUDA10_Registers_Kernel.h"
#define SALT 1770
#include "CUDA10_Registers_Kernel.h"
#define SALT 1771
#include "CUDA10_Registers_Kernel.h"
#define SALT 1772
#include "CUDA10_Registers_Kernel.h"
#define SALT 1773
#include "CUDA10_Registers_Kernel.h"
#define SALT 1774
#include "CUDA10_Registers_Kernel.h"
#define SALT 1775
#include "CUDA10_Registers_Kernel.h"
#define SALT 1776
#include "CUDA10_Registers_Kernel.h"
#define SALT 1777
#include "CUDA10_Registers_Kernel.h"
#define SALT 1778
#include "CUDA10_Registers_Kernel.h"
#define SALT 1779
#include "CUDA10_Registers_Kernel.h"
#define SALT 1780
#include "CUDA10_Registers_Kernel.h"
#define SALT 1781
#include "CUDA10_Registers_Kernel.h"
#define SALT 1782
#include "CUDA10_Registers_Kernel.h"
#define SALT 1783
#include "CUDA10_Registers_Kernel.h"
#define SALT 1784
#include "CUDA10_Registers_Kernel.h"
#define SALT 1785
#include "CUDA10_Registers_Kernel.h"
#define SALT 1786
#include "CUDA10_Registers_Kernel.h"
#define SALT 1787
#include "CUDA10_Registers_Kernel.h"
#define SALT 1788
#include "CUDA10_Registers_Kernel.h"
#define SALT 1789
#include "CUDA10_Registers_Kernel.h"
#define SALT 1790
#include "CUDA10_Registers_Kernel.h"
#define SALT 1791
#include "CUDA10_Registers_Kernel.h"
#define SALT 1792
#include "CUDA10_Registers_Kernel.h"
#define SALT 1793
#include "CUDA10_Registers_Kernel.h"
#define SALT 1794
#include "CUDA10_Registers_Kernel.h"
#define SALT 1795
#include "CUDA10_Registers_Kernel.h"
#define SALT 1796
#include "CUDA10_Registers_Kernel.h"
#define SALT 1797
#include "CUDA10_Registers_Kernel.h"
#define SALT 1798
#include "CUDA10_Registers_Kernel.h"
#define SALT 1799
#include "CUDA10_Registers_Kernel.h"
#define SALT 1800
#include "CUDA10_Registers_Kernel.h"
#define SALT 1801
#include "CUDA10_Registers_Kernel.h"
#define SALT 1802
#include "CUDA10_Registers_Kernel.h"
#define SALT 1803
#include "CUDA10_Registers_Kernel.h"
#define SALT 1804
#include "CUDA10_Registers_Kernel.h"
#define SALT 1805
#include "CUDA10_Registers_Kernel.h"
#define SALT 1806
#include "CUDA10_Registers_Kernel.h"
#define SALT 1807
#include "CUDA10_Registers_Kernel.h"
#define SALT 1808
#include "CUDA10_Registers_Kernel.h"
#define SALT 1809
#include "CUDA10_Registers_Kernel.h"
#define SALT 1810
#include "CUDA10_Registers_Kernel.h"
#define SALT 1811
#include "CUDA10_Registers_Kernel.h"
#define SALT 1812
#include "CUDA10_Registers_Kernel.h"
#define SALT 1813
#include "CUDA10_Registers_Kernel.h"
#define SALT 1814
#include "CUDA10_Registers_Kernel.h"
#define SALT 1815
#include "CUDA10_Registers_Kernel.h"
#define SALT 1816
#include "CUDA10_Registers_Kernel.h"
#define SALT 1817
#include "CUDA10_Registers_Kernel.h"
#define SALT 1818
#include "CUDA10_Registers_Kernel.h"
#define SALT 1819
#include "CUDA10_Registers_Kernel.h"
#define SALT 1820
#include "CUDA10_Registers_Kernel.h"
#define SALT 1821
#include "CUDA10_Registers_Kernel.h"
#define SALT 1822
#include "CUDA10_Registers_Kernel.h"
#define SALT 1823
#include "CUDA10_Registers_Kernel.h"
#define SALT 1824
#include "CUDA10_Registers_Kernel.h"
#define SALT 1825
#include "CUDA10_Registers_Kernel.h"
#define SALT 1826
#include "CUDA10_Registers_Kernel.h"
#define SALT 1827
#include "CUDA10_Registers_Kernel.h"
#define SALT 1828
#include "CUDA10_Registers_Kernel.h"
#define SALT 1829
#include "CUDA10_Registers_Kernel.h"
#define SALT 1830
#include "CUDA10_Registers_Kernel.h"
#define SALT 1831
#include "CUDA10_Registers_Kernel.h"
#define SALT 1832
#include "CUDA10_Registers_Kernel.h"
#define SALT 1833
#include "CUDA10_Registers_Kernel.h"
#define SALT 1834
#include "CUDA10_Registers_Kernel.h"
#define SALT 1835
#include "CUDA10_Registers_Kernel.h"
#define SALT 1836
#include "CUDA10_Registers_Kernel.h"
#define SALT 1837
#include "CUDA10_Registers_Kernel.h"
#define SALT 1838
#include "CUDA10_Registers_Kernel.h"
#define SALT 1839
#include "CUDA10_Registers_Kernel.h"
#define SALT 1840
#include "CUDA10_Registers_Kernel.h"
#define SALT 1841
#include "CUDA10_Registers_Kernel.h"
#define SALT 1842
#include "CUDA10_Registers_Kernel.h"
#define SALT 1843
#include "CUDA10_Registers_Kernel.h"
#define SALT 1844
#include "CUDA10_Registers_Kernel.h"
#define SALT 1845
#include "CUDA10_Registers_Kernel.h"
#define SALT 1846
#include "CUDA10_Registers_Kernel.h"
#define SALT 1847
#include "CUDA10_Registers_Kernel.h"
#define SALT 1848
#include "CUDA10_Registers_Kernel.h"
#define SALT 1849
#include "CUDA10_Registers_Kernel.h"
#define SALT 1850
#include "CUDA10_Registers_Kernel.h"
#define SALT 1851
#include "CUDA10_Registers_Kernel.h"
#define SALT 1852
#include "CUDA10_Registers_Kernel.h"
#define SALT 1853
#include "CUDA10_Registers_Kernel.h"
#define SALT 1854
#include "CUDA10_Registers_Kernel.h"
#define SALT 1855
#include "CUDA10_Registers_Kernel.h"
#define SALT 1856
#include "CUDA10_Registers_Kernel.h"
#define SALT 1857
#include "CUDA10_Registers_Kernel.h"
#define SALT 1858
#include "CUDA10_Registers_Kernel.h"
#define SALT 1859
#include "CUDA10_Registers_Kernel.h"
#define SALT 1860
#include "CUDA10_Registers_Kernel.h"
#define SALT 1861
#include "CUDA10_Registers_Kernel.h"
#define SALT 1862
#include "CUDA10_Registers_Kernel.h"
#define SALT 1863
#include "CUDA10_Registers_Kernel.h"
#define SALT 1864
#include "CUDA10_Registers_Kernel.h"
#define SALT 1865
#include "CUDA10_Registers_Kernel.h"
#define SALT 1866
#include "CUDA10_Registers_Kernel.h"
#define SALT 1867
#include "CUDA10_Registers_Kernel.h"
#define SALT 1868
#include "CUDA10_Registers_Kernel.h"
#define SALT 1869
#include "CUDA10_Registers_Kernel.h"
#define SALT 1870
#include "CUDA10_Registers_Kernel.h"
#define SALT 1871
#include "CUDA10_Registers_Kernel.h"
#define SALT 1872
#include "CUDA10_Registers_Kernel.h"
#define SALT 1873
#include "CUDA10_Registers_Kernel.h"
#define SALT 1874
#include "CUDA10_Registers_Kernel.h"
#define SALT 1875
#include "CUDA10_Registers_Kernel.h"
#define SALT 1876
#include "CUDA10_Registers_Kernel.h"
#define SALT 1877
#include "CUDA10_Registers_Kernel.h"
#define SALT 1878
#include "CUDA10_Registers_Kernel.h"
#define SALT 1879
#include "CUDA10_Registers_Kernel.h"
#define SALT 1880
#include "CUDA10_Registers_Kernel.h"
#define SALT 1881
#include "CUDA10_Registers_Kernel.h"
#define SALT 1882
#include "CUDA10_Registers_Kernel.h"
#define SALT 1883
#include "CUDA10_Registers_Kernel.h"
#define SALT 1884
#include "CUDA10_Registers_Kernel.h"
#define SALT 1885
#include "CUDA10_Registers_Kernel.h"
#define SALT 1886
#include "CUDA10_Registers_Kernel.h"
#define SALT 1887
#include "CUDA10_Registers_Kernel.h"
#define SALT 1888
#include "CUDA10_Registers_Kernel.h"
#define SALT 1889
#include "CUDA10_Registers_Kernel.h"
#define SALT 1890
#include "CUDA10_Registers_Kernel.h"
#define SALT 1891
#include "CUDA10_Registers_Kernel.h"
#define SALT 1892
#include "CUDA10_Registers_Kernel.h"
#define SALT 1893
#include "CUDA10_Registers_Kernel.h"
#define SALT 1894
#include "CUDA10_Registers_Kernel.h"
#define SALT 1895
#include "CUDA10_Registers_Kernel.h"
#define SALT 1896
#include "CUDA10_Registers_Kernel.h"
#define SALT 1897
#include "CUDA10_Registers_Kernel.h"
#define SALT 1898
#include "CUDA10_Registers_Kernel.h"
#define SALT 1899
#include "CUDA10_Registers_Kernel.h"
#define SALT 1900
#include "CUDA10_Registers_Kernel.h"
#define SALT 1901
#include "CUDA10_Registers_Kernel.h"
#define SALT 1902
#include "CUDA10_Registers_Kernel.h"
#define SALT 1903
#include "CUDA10_Registers_Kernel.h"
#define SALT 1904
#include "CUDA10_Registers_Kernel.h"
#define SALT 1905
#include "CUDA10_Registers_Kernel.h"
#define SALT 1906
#include "CUDA10_Registers_Kernel.h"
#define SALT 1907
#include "CUDA10_Registers_Kernel.h"
#define SALT 1908
#include "CUDA10_Registers_Kernel.h"
#define SALT 1909
#include "CUDA10_Registers_Kernel.h"
#define SALT 1910
#include "CUDA10_Registers_Kernel.h"
#define SALT 1911
#include "CUDA10_Registers_Kernel.h"
#define SALT 1912
#include "CUDA10_Registers_Kernel.h"
#define SALT 1913
#include "CUDA10_Registers_Kernel.h"
#define SALT 1914
#include "CUDA10_Registers_Kernel.h"
#define SALT 1915
#include "CUDA10_Registers_Kernel.h"
#define SALT 1916
#include "CUDA10_Registers_Kernel.h"
#define SALT 1917
#include "CUDA10_Registers_Kernel.h"
#define SALT 1918
#include "CUDA10_Registers_Kernel.h"
#define SALT 1919
#include "CUDA10_Registers_Kernel.h"
#define SALT 1920
#include "CUDA10_Registers_Kernel.h"
#define SALT 1921
#include "CUDA10_Registers_Kernel.h"
#define SALT 1922
#include "CUDA10_Registers_Kernel.h"
#define SALT 1923
#include "CUDA10_Registers_Kernel.h"
#define SALT 1924
#include "CUDA10_Registers_Kernel.h"
#define SALT 1925
#include "CUDA10_Registers_Kernel.h"
#define SALT 1926
#include "CUDA10_Registers_Kernel.h"
#define SALT 1927
#include "CUDA10_Registers_Kernel.h"
#define SALT 1928
#include "CUDA10_Registers_Kernel.h"
#define SALT 1929
#include "CUDA10_Registers_Kernel.h"
#define SALT 1930
#include "CUDA10_Registers_Kernel.h"
#define SALT 1931
#include "CUDA10_Registers_Kernel.h"
#define SALT 1932
#include "CUDA10_Registers_Kernel.h"
#define SALT 1933
#include "CUDA10_Registers_Kernel.h"
#define SALT 1934
#include "CUDA10_Registers_Kernel.h"
#define SALT 1935
#include "CUDA10_Registers_Kernel.h"
#define SALT 1936
#include "CUDA10_Registers_Kernel.h"
#define SALT 1937
#include "CUDA10_Registers_Kernel.h"
#define SALT 1938
#include "CUDA10_Registers_Kernel.h"
#define SALT 1939
#include "CUDA10_Registers_Kernel.h"
#define SALT 1940
#include "CUDA10_Registers_Kernel.h"
#define SALT 1941
#include "CUDA10_Registers_Kernel.h"
#define SALT 1942
#include "CUDA10_Registers_Kernel.h"
#define SALT 1943
#include "CUDA10_Registers_Kernel.h"
#define SALT 1944
#include "CUDA10_Registers_Kernel.h"
#define SALT 1945
#include "CUDA10_Registers_Kernel.h"
#define SALT 1946
#include "CUDA10_Registers_Kernel.h"
#define SALT 1947
#include "CUDA10_Registers_Kernel.h"
#define SALT 1948
#include "CUDA10_Registers_Kernel.h"
#define SALT 1949
#include "CUDA10_Registers_Kernel.h"
#define SALT 1950
#include "CUDA10_Registers_Kernel.h"
#define SALT 1951
#include "CUDA10_Registers_Kernel.h"
#define SALT 1952
#include "CUDA10_Registers_Kernel.h"
#define SALT 1953
#include "CUDA10_Registers_Kernel.h"
#define SALT 1954
#include "CUDA10_Registers_Kernel.h"
#define SALT 1955
#include "CUDA10_Registers_Kernel.h"
#define SALT 1956
#include "CUDA10_Registers_Kernel.h"
#define SALT 1957
#include "CUDA10_Registers_Kernel.h"
#define SALT 1958
#include "CUDA10_Registers_Kernel.h"
#define SALT 1959
#include "CUDA10_Registers_Kernel.h"
#define SALT 1960
#include "CUDA10_Registers_Kernel.h"
#define SALT 1961
#include "CUDA10_Registers_Kernel.h"
#define SALT 1962
#include "CUDA10_Registers_Kernel.h"
#define SALT 1963
#include "CUDA10_Registers_Kernel.h"
#define SALT 1964
#include "CUDA10_Registers_Kernel.h"
#define SALT 1965
#include "CUDA10_Registers_Kernel.h"
#define SALT 1966
#include "CUDA10_Registers_Kernel.h"
#define SALT 1967
#include "CUDA10_Registers_Kernel.h"
#define SALT 1968
#include "CUDA10_Registers_Kernel.h"
#define SALT 1969
#include "CUDA10_Registers_Kernel.h"
#define SALT 1970
#include "CUDA10_Registers_Kernel.h"
#define SALT 1971
#include "CUDA10_Registers_Kernel.h"
#define SALT 1972
#include "CUDA10_Registers_Kernel.h"
#define SALT 1973
#include "CUDA10_Registers_Kernel.h"
#define SALT 1974
#include "CUDA10_Registers_Kernel.h"
#define SALT 1975
#include "CUDA10_Registers_Kernel.h"
#define SALT 1976
#include "CUDA10_Registers_Kernel.h"
#define SALT 1977
#include "CUDA10_Registers_Kernel.h"
#define SALT 1978
#include "CUDA10_Registers_Kernel.h"
#define SALT 1979
#include "CUDA10_Registers_Kernel.h"
#define SALT 1980
#include "CUDA10_Registers_Kernel.h"
#define SALT 1981
#include "CUDA10_Registers_Kernel.h"
#define SALT 1982
#include "CUDA10_Registers_Kernel.h"
#define SALT 1983
#include "CUDA10_Registers_Kernel.h"
#define SALT 1984
#include "CUDA10_Registers_Kernel.h"
#define SALT 1985
#include "CUDA10_Registers_Kernel.h"
#define SALT 1986
#include "CUDA10_Registers_Kernel.h"
#define SALT 1987
#include "CUDA10_Registers_Kernel.h"
#define SALT 1988
#include "CUDA10_Registers_Kernel.h"
#define SALT 1989
#include "CUDA10_Registers_Kernel.h"
#define SALT 1990
#include "CUDA10_Registers_Kernel.h"
#define SALT 1991
#include "CUDA10_Registers_Kernel.h"
#define SALT 1992
#include "CUDA10_Registers_Kernel.h"
#define SALT 1993
#include "CUDA10_Registers_Kernel.h"
#define SALT 1994
#include "CUDA10_Registers_Kernel.h"
#define SALT 1995
#include "CUDA10_Registers_Kernel.h"
#define SALT 1996
#include "CUDA10_Registers_Kernel.h"
#define SALT 1997
#include "CUDA10_Registers_Kernel.h"
#define SALT 1998
#include "CUDA10_Registers_Kernel.h"
#define SALT 1999
#include "CUDA10_Registers_Kernel.h"
#define SALT 2000
#include "CUDA10_Registers_Kernel.h"
#define SALT 2001
#include "CUDA10_Registers_Kernel.h"
#define SALT 2002
#include "CUDA10_Registers_Kernel.h"
#define SALT 2003
#include "CUDA10_Registers_Kernel.h"
#define SALT 2004
#include "CUDA10_Registers_Kernel.h"
#define SALT 2005
#include "CUDA10_Registers_Kernel.h"
#define SALT 2006
#include "CUDA10_Registers_Kernel.h"
#define SALT 2007
#include "CUDA10_Registers_Kernel.h"
#define SALT 2008
#include "CUDA10_Registers_Kernel.h"
#define SALT 2009
#include "CUDA10_Registers_Kernel.h"
#define SALT 2010
#include "CUDA10_Registers_Kernel.h"
#define SALT 2011
#include "CUDA10_Registers_Kernel.h"
#define SALT 2012
#include "CUDA10_Registers_Kernel.h"
#define SALT 2013
#include "CUDA10_Registers_Kernel.h"
#define SALT 2014
#include "CUDA10_Registers_Kernel.h"
#define SALT 2015
#include "CUDA10_Registers_Kernel.h"
#define SALT 2016
#include "CUDA10_Registers_Kernel.h"
#define SALT 2017
#include "CUDA10_Registers_Kernel.h"
#define SALT 2018
#include "CUDA10_Registers_Kernel.h"
#define SALT 2019
#include "CUDA10_Registers_Kernel.h"
#define SALT 2020
#include "CUDA10_Registers_Kernel.h"
#define SALT 2021
#include "CUDA10_Registers_Kernel.h"
#define SALT 2022
#include "CUDA10_Registers_Kernel.h"
#define SALT 2023
#include "CUDA10_Registers_Kernel.h"
#define SALT 2024
#include "CUDA10_Registers_Kernel.h"
#define SALT 2025
#include "CUDA10_Registers_Kernel.h"
#define SALT 2026
#include "CUDA10_Registers_Kernel.h"
#define SALT 2027
#include "CUDA10_Registers_Kernel.h"
#define SALT 2028
#include "CUDA10_Registers_Kernel.h"
#define SALT 2029
#include "CUDA10_Registers_Kernel.h"
#define SALT 2030
#include "CUDA10_Registers_Kernel.h"
#define SALT 2031
#include "CUDA10_Registers_Kernel.h"
#define SALT 2032
#include "CUDA10_Registers_Kernel.h"
#define SALT 2033
#include "CUDA10_Registers_Kernel.h"
#define SALT 2034
#include "CUDA10_Registers_Kernel.h"
#define SALT 2035
#include "CUDA10_Registers_Kernel.h"
#define SALT 2036
#include "CUDA10_Registers_Kernel.h"
#define SALT 2037
#include "CUDA10_Registers_Kernel.h"
#define SALT 2038
#include "CUDA10_Registers_Kernel.h"
#define SALT 2039
#include "CUDA10_Registers_Kernel.h"
#define SALT 2040
#include "CUDA10_Registers_Kernel.h"
#define SALT 2041
#include "CUDA10_Registers_Kernel.h"
#define SALT 2042
#include "CUDA10_Registers_Kernel.h"
#define SALT 2043
#include "CUDA10_Registers_Kernel.h"
#define SALT 2044
#include "CUDA10_Registers_Kernel.h"
#define SALT 2045
#include "CUDA10_Registers_Kernel.h"
#define SALT 2046
#include "CUDA10_Registers_Kernel.h"
#define SALT 2047
#include "CUDA10_Registers_Kernel.h"



void CUDA_DES_InitializeKernelLauncher3()
{
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_FirstByte,   keyCharTable_FirstByte,   SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaKeyCharTable_SecondByte,  keyCharTable_SecondByte,  SIZE_KEY_CHAR_TABLE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaChunkBitmap,               chunkBitmap,               CHUNK_BITMAP_SIZE));
	CUDA_ERROR(cudaMemcpyToSymbol(cudaCompactMediumChunkBitmap,    compactMediumChunkBitmap,  COMPACT_MEDIUM_CHUNK_BITMAP_SIZE));
}

void CUDA_DES_LaunchKernel3(
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
	case 1536: LAUNCH_KERNEL(1536); break;
	case 1537: LAUNCH_KERNEL(1537); break;
	case 1538: LAUNCH_KERNEL(1538); break;
	case 1539: LAUNCH_KERNEL(1539); break;
	case 1540: LAUNCH_KERNEL(1540); break;
	case 1541: LAUNCH_KERNEL(1541); break;
	case 1542: LAUNCH_KERNEL(1542); break;
	case 1543: LAUNCH_KERNEL(1543); break;
	case 1544: LAUNCH_KERNEL(1544); break;
	case 1545: LAUNCH_KERNEL(1545); break;
	case 1546: LAUNCH_KERNEL(1546); break;
	case 1547: LAUNCH_KERNEL(1547); break;
	case 1548: LAUNCH_KERNEL(1548); break;
	case 1549: LAUNCH_KERNEL(1549); break;
	case 1550: LAUNCH_KERNEL(1550); break;
	case 1551: LAUNCH_KERNEL(1551); break;
	case 1552: LAUNCH_KERNEL(1552); break;
	case 1553: LAUNCH_KERNEL(1553); break;
	case 1554: LAUNCH_KERNEL(1554); break;
	case 1555: LAUNCH_KERNEL(1555); break;
	case 1556: LAUNCH_KERNEL(1556); break;
	case 1557: LAUNCH_KERNEL(1557); break;
	case 1558: LAUNCH_KERNEL(1558); break;
	case 1559: LAUNCH_KERNEL(1559); break;
	case 1560: LAUNCH_KERNEL(1560); break;
	case 1561: LAUNCH_KERNEL(1561); break;
	case 1562: LAUNCH_KERNEL(1562); break;
	case 1563: LAUNCH_KERNEL(1563); break;
	case 1564: LAUNCH_KERNEL(1564); break;
	case 1565: LAUNCH_KERNEL(1565); break;
	case 1566: LAUNCH_KERNEL(1566); break;
	case 1567: LAUNCH_KERNEL(1567); break;
	case 1568: LAUNCH_KERNEL(1568); break;
	case 1569: LAUNCH_KERNEL(1569); break;
	case 1570: LAUNCH_KERNEL(1570); break;
	case 1571: LAUNCH_KERNEL(1571); break;
	case 1572: LAUNCH_KERNEL(1572); break;
	case 1573: LAUNCH_KERNEL(1573); break;
	case 1574: LAUNCH_KERNEL(1574); break;
	case 1575: LAUNCH_KERNEL(1575); break;
	case 1576: LAUNCH_KERNEL(1576); break;
	case 1577: LAUNCH_KERNEL(1577); break;
	case 1578: LAUNCH_KERNEL(1578); break;
	case 1579: LAUNCH_KERNEL(1579); break;
	case 1580: LAUNCH_KERNEL(1580); break;
	case 1581: LAUNCH_KERNEL(1581); break;
	case 1582: LAUNCH_KERNEL(1582); break;
	case 1583: LAUNCH_KERNEL(1583); break;
	case 1584: LAUNCH_KERNEL(1584); break;
	case 1585: LAUNCH_KERNEL(1585); break;
	case 1586: LAUNCH_KERNEL(1586); break;
	case 1587: LAUNCH_KERNEL(1587); break;
	case 1588: LAUNCH_KERNEL(1588); break;
	case 1589: LAUNCH_KERNEL(1589); break;
	case 1590: LAUNCH_KERNEL(1590); break;
	case 1591: LAUNCH_KERNEL(1591); break;
	case 1592: LAUNCH_KERNEL(1592); break;
	case 1593: LAUNCH_KERNEL(1593); break;
	case 1594: LAUNCH_KERNEL(1594); break;
	case 1595: LAUNCH_KERNEL(1595); break;
	case 1596: LAUNCH_KERNEL(1596); break;
	case 1597: LAUNCH_KERNEL(1597); break;
	case 1598: LAUNCH_KERNEL(1598); break;
	case 1599: LAUNCH_KERNEL(1599); break;
	case 1600: LAUNCH_KERNEL(1600); break;
	case 1601: LAUNCH_KERNEL(1601); break;
	case 1602: LAUNCH_KERNEL(1602); break;
	case 1603: LAUNCH_KERNEL(1603); break;
	case 1604: LAUNCH_KERNEL(1604); break;
	case 1605: LAUNCH_KERNEL(1605); break;
	case 1606: LAUNCH_KERNEL(1606); break;
	case 1607: LAUNCH_KERNEL(1607); break;
	case 1608: LAUNCH_KERNEL(1608); break;
	case 1609: LAUNCH_KERNEL(1609); break;
	case 1610: LAUNCH_KERNEL(1610); break;
	case 1611: LAUNCH_KERNEL(1611); break;
	case 1612: LAUNCH_KERNEL(1612); break;
	case 1613: LAUNCH_KERNEL(1613); break;
	case 1614: LAUNCH_KERNEL(1614); break;
	case 1615: LAUNCH_KERNEL(1615); break;
	case 1616: LAUNCH_KERNEL(1616); break;
	case 1617: LAUNCH_KERNEL(1617); break;
	case 1618: LAUNCH_KERNEL(1618); break;
	case 1619: LAUNCH_KERNEL(1619); break;
	case 1620: LAUNCH_KERNEL(1620); break;
	case 1621: LAUNCH_KERNEL(1621); break;
	case 1622: LAUNCH_KERNEL(1622); break;
	case 1623: LAUNCH_KERNEL(1623); break;
	case 1624: LAUNCH_KERNEL(1624); break;
	case 1625: LAUNCH_KERNEL(1625); break;
	case 1626: LAUNCH_KERNEL(1626); break;
	case 1627: LAUNCH_KERNEL(1627); break;
	case 1628: LAUNCH_KERNEL(1628); break;
	case 1629: LAUNCH_KERNEL(1629); break;
	case 1630: LAUNCH_KERNEL(1630); break;
	case 1631: LAUNCH_KERNEL(1631); break;
	case 1632: LAUNCH_KERNEL(1632); break;
	case 1633: LAUNCH_KERNEL(1633); break;
	case 1634: LAUNCH_KERNEL(1634); break;
	case 1635: LAUNCH_KERNEL(1635); break;
	case 1636: LAUNCH_KERNEL(1636); break;
	case 1637: LAUNCH_KERNEL(1637); break;
	case 1638: LAUNCH_KERNEL(1638); break;
	case 1639: LAUNCH_KERNEL(1639); break;
	case 1640: LAUNCH_KERNEL(1640); break;
	case 1641: LAUNCH_KERNEL(1641); break;
	case 1642: LAUNCH_KERNEL(1642); break;
	case 1643: LAUNCH_KERNEL(1643); break;
	case 1644: LAUNCH_KERNEL(1644); break;
	case 1645: LAUNCH_KERNEL(1645); break;
	case 1646: LAUNCH_KERNEL(1646); break;
	case 1647: LAUNCH_KERNEL(1647); break;
	case 1648: LAUNCH_KERNEL(1648); break;
	case 1649: LAUNCH_KERNEL(1649); break;
	case 1650: LAUNCH_KERNEL(1650); break;
	case 1651: LAUNCH_KERNEL(1651); break;
	case 1652: LAUNCH_KERNEL(1652); break;
	case 1653: LAUNCH_KERNEL(1653); break;
	case 1654: LAUNCH_KERNEL(1654); break;
	case 1655: LAUNCH_KERNEL(1655); break;
	case 1656: LAUNCH_KERNEL(1656); break;
	case 1657: LAUNCH_KERNEL(1657); break;
	case 1658: LAUNCH_KERNEL(1658); break;
	case 1659: LAUNCH_KERNEL(1659); break;
	case 1660: LAUNCH_KERNEL(1660); break;
	case 1661: LAUNCH_KERNEL(1661); break;
	case 1662: LAUNCH_KERNEL(1662); break;
	case 1663: LAUNCH_KERNEL(1663); break;
	case 1664: LAUNCH_KERNEL(1664); break;
	case 1665: LAUNCH_KERNEL(1665); break;
	case 1666: LAUNCH_KERNEL(1666); break;
	case 1667: LAUNCH_KERNEL(1667); break;
	case 1668: LAUNCH_KERNEL(1668); break;
	case 1669: LAUNCH_KERNEL(1669); break;
	case 1670: LAUNCH_KERNEL(1670); break;
	case 1671: LAUNCH_KERNEL(1671); break;
	case 1672: LAUNCH_KERNEL(1672); break;
	case 1673: LAUNCH_KERNEL(1673); break;
	case 1674: LAUNCH_KERNEL(1674); break;
	case 1675: LAUNCH_KERNEL(1675); break;
	case 1676: LAUNCH_KERNEL(1676); break;
	case 1677: LAUNCH_KERNEL(1677); break;
	case 1678: LAUNCH_KERNEL(1678); break;
	case 1679: LAUNCH_KERNEL(1679); break;
	case 1680: LAUNCH_KERNEL(1680); break;
	case 1681: LAUNCH_KERNEL(1681); break;
	case 1682: LAUNCH_KERNEL(1682); break;
	case 1683: LAUNCH_KERNEL(1683); break;
	case 1684: LAUNCH_KERNEL(1684); break;
	case 1685: LAUNCH_KERNEL(1685); break;
	case 1686: LAUNCH_KERNEL(1686); break;
	case 1687: LAUNCH_KERNEL(1687); break;
	case 1688: LAUNCH_KERNEL(1688); break;
	case 1689: LAUNCH_KERNEL(1689); break;
	case 1690: LAUNCH_KERNEL(1690); break;
	case 1691: LAUNCH_KERNEL(1691); break;
	case 1692: LAUNCH_KERNEL(1692); break;
	case 1693: LAUNCH_KERNEL(1693); break;
	case 1694: LAUNCH_KERNEL(1694); break;
	case 1695: LAUNCH_KERNEL(1695); break;
	case 1696: LAUNCH_KERNEL(1696); break;
	case 1697: LAUNCH_KERNEL(1697); break;
	case 1698: LAUNCH_KERNEL(1698); break;
	case 1699: LAUNCH_KERNEL(1699); break;
	case 1700: LAUNCH_KERNEL(1700); break;
	case 1701: LAUNCH_KERNEL(1701); break;
	case 1702: LAUNCH_KERNEL(1702); break;
	case 1703: LAUNCH_KERNEL(1703); break;
	case 1704: LAUNCH_KERNEL(1704); break;
	case 1705: LAUNCH_KERNEL(1705); break;
	case 1706: LAUNCH_KERNEL(1706); break;
	case 1707: LAUNCH_KERNEL(1707); break;
	case 1708: LAUNCH_KERNEL(1708); break;
	case 1709: LAUNCH_KERNEL(1709); break;
	case 1710: LAUNCH_KERNEL(1710); break;
	case 1711: LAUNCH_KERNEL(1711); break;
	case 1712: LAUNCH_KERNEL(1712); break;
	case 1713: LAUNCH_KERNEL(1713); break;
	case 1714: LAUNCH_KERNEL(1714); break;
	case 1715: LAUNCH_KERNEL(1715); break;
	case 1716: LAUNCH_KERNEL(1716); break;
	case 1717: LAUNCH_KERNEL(1717); break;
	case 1718: LAUNCH_KERNEL(1718); break;
	case 1719: LAUNCH_KERNEL(1719); break;
	case 1720: LAUNCH_KERNEL(1720); break;
	case 1721: LAUNCH_KERNEL(1721); break;
	case 1722: LAUNCH_KERNEL(1722); break;
	case 1723: LAUNCH_KERNEL(1723); break;
	case 1724: LAUNCH_KERNEL(1724); break;
	case 1725: LAUNCH_KERNEL(1725); break;
	case 1726: LAUNCH_KERNEL(1726); break;
	case 1727: LAUNCH_KERNEL(1727); break;
	case 1728: LAUNCH_KERNEL(1728); break;
	case 1729: LAUNCH_KERNEL(1729); break;
	case 1730: LAUNCH_KERNEL(1730); break;
	case 1731: LAUNCH_KERNEL(1731); break;
	case 1732: LAUNCH_KERNEL(1732); break;
	case 1733: LAUNCH_KERNEL(1733); break;
	case 1734: LAUNCH_KERNEL(1734); break;
	case 1735: LAUNCH_KERNEL(1735); break;
	case 1736: LAUNCH_KERNEL(1736); break;
	case 1737: LAUNCH_KERNEL(1737); break;
	case 1738: LAUNCH_KERNEL(1738); break;
	case 1739: LAUNCH_KERNEL(1739); break;
	case 1740: LAUNCH_KERNEL(1740); break;
	case 1741: LAUNCH_KERNEL(1741); break;
	case 1742: LAUNCH_KERNEL(1742); break;
	case 1743: LAUNCH_KERNEL(1743); break;
	case 1744: LAUNCH_KERNEL(1744); break;
	case 1745: LAUNCH_KERNEL(1745); break;
	case 1746: LAUNCH_KERNEL(1746); break;
	case 1747: LAUNCH_KERNEL(1747); break;
	case 1748: LAUNCH_KERNEL(1748); break;
	case 1749: LAUNCH_KERNEL(1749); break;
	case 1750: LAUNCH_KERNEL(1750); break;
	case 1751: LAUNCH_KERNEL(1751); break;
	case 1752: LAUNCH_KERNEL(1752); break;
	case 1753: LAUNCH_KERNEL(1753); break;
	case 1754: LAUNCH_KERNEL(1754); break;
	case 1755: LAUNCH_KERNEL(1755); break;
	case 1756: LAUNCH_KERNEL(1756); break;
	case 1757: LAUNCH_KERNEL(1757); break;
	case 1758: LAUNCH_KERNEL(1758); break;
	case 1759: LAUNCH_KERNEL(1759); break;
	case 1760: LAUNCH_KERNEL(1760); break;
	case 1761: LAUNCH_KERNEL(1761); break;
	case 1762: LAUNCH_KERNEL(1762); break;
	case 1763: LAUNCH_KERNEL(1763); break;
	case 1764: LAUNCH_KERNEL(1764); break;
	case 1765: LAUNCH_KERNEL(1765); break;
	case 1766: LAUNCH_KERNEL(1766); break;
	case 1767: LAUNCH_KERNEL(1767); break;
	case 1768: LAUNCH_KERNEL(1768); break;
	case 1769: LAUNCH_KERNEL(1769); break;
	case 1770: LAUNCH_KERNEL(1770); break;
	case 1771: LAUNCH_KERNEL(1771); break;
	case 1772: LAUNCH_KERNEL(1772); break;
	case 1773: LAUNCH_KERNEL(1773); break;
	case 1774: LAUNCH_KERNEL(1774); break;
	case 1775: LAUNCH_KERNEL(1775); break;
	case 1776: LAUNCH_KERNEL(1776); break;
	case 1777: LAUNCH_KERNEL(1777); break;
	case 1778: LAUNCH_KERNEL(1778); break;
	case 1779: LAUNCH_KERNEL(1779); break;
	case 1780: LAUNCH_KERNEL(1780); break;
	case 1781: LAUNCH_KERNEL(1781); break;
	case 1782: LAUNCH_KERNEL(1782); break;
	case 1783: LAUNCH_KERNEL(1783); break;
	case 1784: LAUNCH_KERNEL(1784); break;
	case 1785: LAUNCH_KERNEL(1785); break;
	case 1786: LAUNCH_KERNEL(1786); break;
	case 1787: LAUNCH_KERNEL(1787); break;
	case 1788: LAUNCH_KERNEL(1788); break;
	case 1789: LAUNCH_KERNEL(1789); break;
	case 1790: LAUNCH_KERNEL(1790); break;
	case 1791: LAUNCH_KERNEL(1791); break;
	case 1792: LAUNCH_KERNEL(1792); break;
	case 1793: LAUNCH_KERNEL(1793); break;
	case 1794: LAUNCH_KERNEL(1794); break;
	case 1795: LAUNCH_KERNEL(1795); break;
	case 1796: LAUNCH_KERNEL(1796); break;
	case 1797: LAUNCH_KERNEL(1797); break;
	case 1798: LAUNCH_KERNEL(1798); break;
	case 1799: LAUNCH_KERNEL(1799); break;
	case 1800: LAUNCH_KERNEL(1800); break;
	case 1801: LAUNCH_KERNEL(1801); break;
	case 1802: LAUNCH_KERNEL(1802); break;
	case 1803: LAUNCH_KERNEL(1803); break;
	case 1804: LAUNCH_KERNEL(1804); break;
	case 1805: LAUNCH_KERNEL(1805); break;
	case 1806: LAUNCH_KERNEL(1806); break;
	case 1807: LAUNCH_KERNEL(1807); break;
	case 1808: LAUNCH_KERNEL(1808); break;
	case 1809: LAUNCH_KERNEL(1809); break;
	case 1810: LAUNCH_KERNEL(1810); break;
	case 1811: LAUNCH_KERNEL(1811); break;
	case 1812: LAUNCH_KERNEL(1812); break;
	case 1813: LAUNCH_KERNEL(1813); break;
	case 1814: LAUNCH_KERNEL(1814); break;
	case 1815: LAUNCH_KERNEL(1815); break;
	case 1816: LAUNCH_KERNEL(1816); break;
	case 1817: LAUNCH_KERNEL(1817); break;
	case 1818: LAUNCH_KERNEL(1818); break;
	case 1819: LAUNCH_KERNEL(1819); break;
	case 1820: LAUNCH_KERNEL(1820); break;
	case 1821: LAUNCH_KERNEL(1821); break;
	case 1822: LAUNCH_KERNEL(1822); break;
	case 1823: LAUNCH_KERNEL(1823); break;
	case 1824: LAUNCH_KERNEL(1824); break;
	case 1825: LAUNCH_KERNEL(1825); break;
	case 1826: LAUNCH_KERNEL(1826); break;
	case 1827: LAUNCH_KERNEL(1827); break;
	case 1828: LAUNCH_KERNEL(1828); break;
	case 1829: LAUNCH_KERNEL(1829); break;
	case 1830: LAUNCH_KERNEL(1830); break;
	case 1831: LAUNCH_KERNEL(1831); break;
	case 1832: LAUNCH_KERNEL(1832); break;
	case 1833: LAUNCH_KERNEL(1833); break;
	case 1834: LAUNCH_KERNEL(1834); break;
	case 1835: LAUNCH_KERNEL(1835); break;
	case 1836: LAUNCH_KERNEL(1836); break;
	case 1837: LAUNCH_KERNEL(1837); break;
	case 1838: LAUNCH_KERNEL(1838); break;
	case 1839: LAUNCH_KERNEL(1839); break;
	case 1840: LAUNCH_KERNEL(1840); break;
	case 1841: LAUNCH_KERNEL(1841); break;
	case 1842: LAUNCH_KERNEL(1842); break;
	case 1843: LAUNCH_KERNEL(1843); break;
	case 1844: LAUNCH_KERNEL(1844); break;
	case 1845: LAUNCH_KERNEL(1845); break;
	case 1846: LAUNCH_KERNEL(1846); break;
	case 1847: LAUNCH_KERNEL(1847); break;
	case 1848: LAUNCH_KERNEL(1848); break;
	case 1849: LAUNCH_KERNEL(1849); break;
	case 1850: LAUNCH_KERNEL(1850); break;
	case 1851: LAUNCH_KERNEL(1851); break;
	case 1852: LAUNCH_KERNEL(1852); break;
	case 1853: LAUNCH_KERNEL(1853); break;
	case 1854: LAUNCH_KERNEL(1854); break;
	case 1855: LAUNCH_KERNEL(1855); break;
	case 1856: LAUNCH_KERNEL(1856); break;
	case 1857: LAUNCH_KERNEL(1857); break;
	case 1858: LAUNCH_KERNEL(1858); break;
	case 1859: LAUNCH_KERNEL(1859); break;
	case 1860: LAUNCH_KERNEL(1860); break;
	case 1861: LAUNCH_KERNEL(1861); break;
	case 1862: LAUNCH_KERNEL(1862); break;
	case 1863: LAUNCH_KERNEL(1863); break;
	case 1864: LAUNCH_KERNEL(1864); break;
	case 1865: LAUNCH_KERNEL(1865); break;
	case 1866: LAUNCH_KERNEL(1866); break;
	case 1867: LAUNCH_KERNEL(1867); break;
	case 1868: LAUNCH_KERNEL(1868); break;
	case 1869: LAUNCH_KERNEL(1869); break;
	case 1870: LAUNCH_KERNEL(1870); break;
	case 1871: LAUNCH_KERNEL(1871); break;
	case 1872: LAUNCH_KERNEL(1872); break;
	case 1873: LAUNCH_KERNEL(1873); break;
	case 1874: LAUNCH_KERNEL(1874); break;
	case 1875: LAUNCH_KERNEL(1875); break;
	case 1876: LAUNCH_KERNEL(1876); break;
	case 1877: LAUNCH_KERNEL(1877); break;
	case 1878: LAUNCH_KERNEL(1878); break;
	case 1879: LAUNCH_KERNEL(1879); break;
	case 1880: LAUNCH_KERNEL(1880); break;
	case 1881: LAUNCH_KERNEL(1881); break;
	case 1882: LAUNCH_KERNEL(1882); break;
	case 1883: LAUNCH_KERNEL(1883); break;
	case 1884: LAUNCH_KERNEL(1884); break;
	case 1885: LAUNCH_KERNEL(1885); break;
	case 1886: LAUNCH_KERNEL(1886); break;
	case 1887: LAUNCH_KERNEL(1887); break;
	case 1888: LAUNCH_KERNEL(1888); break;
	case 1889: LAUNCH_KERNEL(1889); break;
	case 1890: LAUNCH_KERNEL(1890); break;
	case 1891: LAUNCH_KERNEL(1891); break;
	case 1892: LAUNCH_KERNEL(1892); break;
	case 1893: LAUNCH_KERNEL(1893); break;
	case 1894: LAUNCH_KERNEL(1894); break;
	case 1895: LAUNCH_KERNEL(1895); break;
	case 1896: LAUNCH_KERNEL(1896); break;
	case 1897: LAUNCH_KERNEL(1897); break;
	case 1898: LAUNCH_KERNEL(1898); break;
	case 1899: LAUNCH_KERNEL(1899); break;
	case 1900: LAUNCH_KERNEL(1900); break;
	case 1901: LAUNCH_KERNEL(1901); break;
	case 1902: LAUNCH_KERNEL(1902); break;
	case 1903: LAUNCH_KERNEL(1903); break;
	case 1904: LAUNCH_KERNEL(1904); break;
	case 1905: LAUNCH_KERNEL(1905); break;
	case 1906: LAUNCH_KERNEL(1906); break;
	case 1907: LAUNCH_KERNEL(1907); break;
	case 1908: LAUNCH_KERNEL(1908); break;
	case 1909: LAUNCH_KERNEL(1909); break;
	case 1910: LAUNCH_KERNEL(1910); break;
	case 1911: LAUNCH_KERNEL(1911); break;
	case 1912: LAUNCH_KERNEL(1912); break;
	case 1913: LAUNCH_KERNEL(1913); break;
	case 1914: LAUNCH_KERNEL(1914); break;
	case 1915: LAUNCH_KERNEL(1915); break;
	case 1916: LAUNCH_KERNEL(1916); break;
	case 1917: LAUNCH_KERNEL(1917); break;
	case 1918: LAUNCH_KERNEL(1918); break;
	case 1919: LAUNCH_KERNEL(1919); break;
	case 1920: LAUNCH_KERNEL(1920); break;
	case 1921: LAUNCH_KERNEL(1921); break;
	case 1922: LAUNCH_KERNEL(1922); break;
	case 1923: LAUNCH_KERNEL(1923); break;
	case 1924: LAUNCH_KERNEL(1924); break;
	case 1925: LAUNCH_KERNEL(1925); break;
	case 1926: LAUNCH_KERNEL(1926); break;
	case 1927: LAUNCH_KERNEL(1927); break;
	case 1928: LAUNCH_KERNEL(1928); break;
	case 1929: LAUNCH_KERNEL(1929); break;
	case 1930: LAUNCH_KERNEL(1930); break;
	case 1931: LAUNCH_KERNEL(1931); break;
	case 1932: LAUNCH_KERNEL(1932); break;
	case 1933: LAUNCH_KERNEL(1933); break;
	case 1934: LAUNCH_KERNEL(1934); break;
	case 1935: LAUNCH_KERNEL(1935); break;
	case 1936: LAUNCH_KERNEL(1936); break;
	case 1937: LAUNCH_KERNEL(1937); break;
	case 1938: LAUNCH_KERNEL(1938); break;
	case 1939: LAUNCH_KERNEL(1939); break;
	case 1940: LAUNCH_KERNEL(1940); break;
	case 1941: LAUNCH_KERNEL(1941); break;
	case 1942: LAUNCH_KERNEL(1942); break;
	case 1943: LAUNCH_KERNEL(1943); break;
	case 1944: LAUNCH_KERNEL(1944); break;
	case 1945: LAUNCH_KERNEL(1945); break;
	case 1946: LAUNCH_KERNEL(1946); break;
	case 1947: LAUNCH_KERNEL(1947); break;
	case 1948: LAUNCH_KERNEL(1948); break;
	case 1949: LAUNCH_KERNEL(1949); break;
	case 1950: LAUNCH_KERNEL(1950); break;
	case 1951: LAUNCH_KERNEL(1951); break;
	case 1952: LAUNCH_KERNEL(1952); break;
	case 1953: LAUNCH_KERNEL(1953); break;
	case 1954: LAUNCH_KERNEL(1954); break;
	case 1955: LAUNCH_KERNEL(1955); break;
	case 1956: LAUNCH_KERNEL(1956); break;
	case 1957: LAUNCH_KERNEL(1957); break;
	case 1958: LAUNCH_KERNEL(1958); break;
	case 1959: LAUNCH_KERNEL(1959); break;
	case 1960: LAUNCH_KERNEL(1960); break;
	case 1961: LAUNCH_KERNEL(1961); break;
	case 1962: LAUNCH_KERNEL(1962); break;
	case 1963: LAUNCH_KERNEL(1963); break;
	case 1964: LAUNCH_KERNEL(1964); break;
	case 1965: LAUNCH_KERNEL(1965); break;
	case 1966: LAUNCH_KERNEL(1966); break;
	case 1967: LAUNCH_KERNEL(1967); break;
	case 1968: LAUNCH_KERNEL(1968); break;
	case 1969: LAUNCH_KERNEL(1969); break;
	case 1970: LAUNCH_KERNEL(1970); break;
	case 1971: LAUNCH_KERNEL(1971); break;
	case 1972: LAUNCH_KERNEL(1972); break;
	case 1973: LAUNCH_KERNEL(1973); break;
	case 1974: LAUNCH_KERNEL(1974); break;
	case 1975: LAUNCH_KERNEL(1975); break;
	case 1976: LAUNCH_KERNEL(1976); break;
	case 1977: LAUNCH_KERNEL(1977); break;
	case 1978: LAUNCH_KERNEL(1978); break;
	case 1979: LAUNCH_KERNEL(1979); break;
	case 1980: LAUNCH_KERNEL(1980); break;
	case 1981: LAUNCH_KERNEL(1981); break;
	case 1982: LAUNCH_KERNEL(1982); break;
	case 1983: LAUNCH_KERNEL(1983); break;
	case 1984: LAUNCH_KERNEL(1984); break;
	case 1985: LAUNCH_KERNEL(1985); break;
	case 1986: LAUNCH_KERNEL(1986); break;
	case 1987: LAUNCH_KERNEL(1987); break;
	case 1988: LAUNCH_KERNEL(1988); break;
	case 1989: LAUNCH_KERNEL(1989); break;
	case 1990: LAUNCH_KERNEL(1990); break;
	case 1991: LAUNCH_KERNEL(1991); break;
	case 1992: LAUNCH_KERNEL(1992); break;
	case 1993: LAUNCH_KERNEL(1993); break;
	case 1994: LAUNCH_KERNEL(1994); break;
	case 1995: LAUNCH_KERNEL(1995); break;
	case 1996: LAUNCH_KERNEL(1996); break;
	case 1997: LAUNCH_KERNEL(1997); break;
	case 1998: LAUNCH_KERNEL(1998); break;
	case 1999: LAUNCH_KERNEL(1999); break;
	case 2000: LAUNCH_KERNEL(2000); break;
	case 2001: LAUNCH_KERNEL(2001); break;
	case 2002: LAUNCH_KERNEL(2002); break;
	case 2003: LAUNCH_KERNEL(2003); break;
	case 2004: LAUNCH_KERNEL(2004); break;
	case 2005: LAUNCH_KERNEL(2005); break;
	case 2006: LAUNCH_KERNEL(2006); break;
	case 2007: LAUNCH_KERNEL(2007); break;
	case 2008: LAUNCH_KERNEL(2008); break;
	case 2009: LAUNCH_KERNEL(2009); break;
	case 2010: LAUNCH_KERNEL(2010); break;
	case 2011: LAUNCH_KERNEL(2011); break;
	case 2012: LAUNCH_KERNEL(2012); break;
	case 2013: LAUNCH_KERNEL(2013); break;
	case 2014: LAUNCH_KERNEL(2014); break;
	case 2015: LAUNCH_KERNEL(2015); break;
	case 2016: LAUNCH_KERNEL(2016); break;
	case 2017: LAUNCH_KERNEL(2017); break;
	case 2018: LAUNCH_KERNEL(2018); break;
	case 2019: LAUNCH_KERNEL(2019); break;
	case 2020: LAUNCH_KERNEL(2020); break;
	case 2021: LAUNCH_KERNEL(2021); break;
	case 2022: LAUNCH_KERNEL(2022); break;
	case 2023: LAUNCH_KERNEL(2023); break;
	case 2024: LAUNCH_KERNEL(2024); break;
	case 2025: LAUNCH_KERNEL(2025); break;
	case 2026: LAUNCH_KERNEL(2026); break;
	case 2027: LAUNCH_KERNEL(2027); break;
	case 2028: LAUNCH_KERNEL(2028); break;
	case 2029: LAUNCH_KERNEL(2029); break;
	case 2030: LAUNCH_KERNEL(2030); break;
	case 2031: LAUNCH_KERNEL(2031); break;
	case 2032: LAUNCH_KERNEL(2032); break;
	case 2033: LAUNCH_KERNEL(2033); break;
	case 2034: LAUNCH_KERNEL(2034); break;
	case 2035: LAUNCH_KERNEL(2035); break;
	case 2036: LAUNCH_KERNEL(2036); break;
	case 2037: LAUNCH_KERNEL(2037); break;
	case 2038: LAUNCH_KERNEL(2038); break;
	case 2039: LAUNCH_KERNEL(2039); break;
	case 2040: LAUNCH_KERNEL(2040); break;
	case 2041: LAUNCH_KERNEL(2041); break;
	case 2042: LAUNCH_KERNEL(2042); break;
	case 2043: LAUNCH_KERNEL(2043); break;
	case 2044: LAUNCH_KERNEL(2044); break;
	case 2045: LAUNCH_KERNEL(2045); break;
	case 2046: LAUNCH_KERNEL(2046); break;
	case 2047: LAUNCH_KERNEL(2047); break;
	default: printf("intSalt: %d\n", intSalt); ASSERT(FALSE);
	}
}

#endif
