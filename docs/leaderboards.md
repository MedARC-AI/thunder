# Leaderboards

## Updates
* **2025-11-21**: **[SPIDER Leaderboard]** H0-mini added to the SPIDER leaderboard.
* **2025-11-21**: **[Up-to-date Rank-sum Leaderboard]** H0-mini added to the updated rank-sum leaderboard.
* **2025-11-14**: **[SPIDER Leaderboard]** DINOv3-S, DINOv3-B, DINOv3-L, GIGAPATH, KAIKO-S/16, KAIKO-B/16 added to the SPIDER leaderboard.
* **2025-11-14**: **[Up-to-date Rank-sum Leaderboard]** GIGAPATH, KAIKO-S/16, KAIKO-B/16 added to the updated rank-sum leaderboard.
* **2025-10-30**: **[Up-to-date Rank-sum Leaderboard]** A new up-to-date rank-sum leaderboard was added. This is an update of the rank-sum leaderboard (Table 4) in our [paper](https://arxiv.org/abs/2507.07860) with new datasets and models, e.g. here we added results for SPIDER datasets and DINOv3 model variants.
* **2025-10-27**: **[Original (paper) Rank-sum Leaderboard]**  Our arXiv paper was updated and now the rank-sum table in it (Table 4) matches exactly our **Original (paper) Rank-sum Leaderboard**.
* **2025-10-06**: **[Zero-shot VLM Classification Leaderboard]** A new zero-shot classification task was integrated into THUNDER. Results are presented in a dedicated leaderboard below.
* **2025-09-30**: **[SPIDER Leaderboard]** Four SPIDER datasets have been integrated into THUNDER. We have created a leaderboard dedicated to SPIDER datasets below.
* **2025-09-01**: **[Original (paper) Rank-sum Leaderboard]** Segmentation results were updated (small changes based on improved performance for all models on the *ocelot* dataset only -> [Related commit](https://github.com/MICS-Lab/thunder/commit/5f6d6e7cdd6a1df5affed2dac47233f80ce5a205)). Segmentation and global rankings do no thus match exactly (a few small differences only) Table 4 from the current version of our [paper](https://arxiv.org/abs/2507.07860). The paper will be updated soon. **[This was now updated on 2025-10-30]**

---

## 🏆 Up-to-date Rank-sum Leaderboard

This leaderboard is an updated version of the rank-sum table (Table 4) in our original [paper](https://arxiv.org/abs/2507.07860).

The following was added (compared with paper results):

* DINOv3 model variants (DINOv3-S, DINOv3-B, DINOv3-L).
* Updated average performance for all models (including DINOv3 models) and all tasks except segmentation with additional results on SPIDER datasets (results from other datasets used to compute the average performance stay the same).
* GIGAPATH.
* KAIKO-S/16 and KAIKO-B/16.
* H0-mini.

<div class="table-responsive-sm">
  <table id="ranksumTableUpToDate" class="table table-hover table-bordered table-sm nowrap">
    <thead class="align-middle text-center">
      <tr>
        <th>Model</th>
        <th>Domain</th>
        <th>Type</th>
        <th>KNN &uarr;</th>
        <th>Lin. prob. &uarr;</th>
        <th>Few-shot &uarr;</th>
        <th>Seg.&uarr;</th>
        <th>Calib. &darr;</th>
        <th>Adv. attack &darr;</th>
        <th>Rank sum &darr;</th>
      </tr>
    </thead>
    <tbody>
        <tr><td>HIBOU-B</td><td>Histopathology</td><td>VM</td><td>78.9 (11)</td><td>81.2 (16)</td><td>76.3 (6)</td><td>67.8 (12)</td><td>3.2 (4)</td><td>52.7 (17)</td><td>66 (10)</td></tr>
          <tr><td>HIBOU-L</td><td>Histopathology</td><td>VM</td><td>78.6 (14)</td><td>83.7 (7)</td><td>73.8 (13)</td><td>68.6 (7)</td><td>4.7 (24)</td><td>39.5 (8)</td><td>73 (11)</td></tr>
          <tr><td>H-OPTIMUS-0</td><td>Histopathology</td><td>VM</td><td>81.4 (5)</td><td>83.8 (5)</td><td>76.2 (7)</td><td>65.2 (16)</td><td>4.0 (16)</td><td>43.9 (13)</td><td>62 (8)</td></tr>
          <tr><td>H-OPTIMUS-1</td><td>Histopathology</td><td>VM</td><td>82.5 (3)</td><td>85.1 (2)</td><td>77.3 (3)</td><td>64.5 (18)</td><td>3.5 (6)</td><td>57.4 (20)</td><td>52 (6)</td></tr>
          <tr><td>MIDNIGHT</td><td>Histopathology</td><td>VM</td><td>79.9 (8)</td><td>84.7 (4)</td><td>71.5 (19)</td><td>68.8 (6)</td><td>2.9 (2)</td><td>37.0 (5)</td><td>44 (5)</td></tr>
          <tr><td>PHIKON</td><td>Histopathology</td><td>VM</td><td>75.7 (18)</td><td>80.9 (18)</td><td>73.6 (14)</td><td>68.0 (10)</td><td>5.8 (29)</td><td>33.5 (3)</td><td>92 (18)</td></tr>
          <tr><td>PHIKON2</td><td>Histopathology</td><td>VM</td><td>73.9 (19)</td><td>79.7 (19)</td><td>71.8 (17)</td><td>67.4 (13)</td><td>3.9 (11)</td><td>43.8 (12)</td><td>91 (17)</td></tr>
          <tr><td>UNI</td><td>Histopathology</td><td>VM</td><td>80.8 (6)</td><td>83.5 (8)</td><td>78.1 (2)</td><td>67.8 (11)</td><td>3.8 (8)</td><td>40.3 (9)</td><td>44 (4)</td></tr>
          <tr><td>UNI2-H</td><td>Histopathology</td><td>VM</td><td>83.3 (1)</td><td>85.7 (1)</td><td>79.8 (1)</td><td>69.0 (4)</td><td>3.9 (12)</td><td>31.7 (2)</td><td>21 (1)</td></tr>
          <tr><td>VIRCHOW</td><td>Histopathology</td><td>VM</td><td>77.4 (17)</td><td>82.8 (11)</td><td>71.8 (18)</td><td>69.2 (2)</td><td>4.5 (20)</td><td>38.3 (6)</td><td>74 (12)</td></tr>
          <tr><td>VIRCHOW2</td><td>Histopathology</td><td>VM</td><td>82.9 (2)</td><td>84.8 (3)</td><td>73.9 (12)</td><td>69.3 (1)</td><td>3.9 (13)</td><td>31.1 (1)</td><td>32 (2)</td></tr>
          <tr><td>CONCH</td><td>Histopathology</td><td>VLM</td><td>78.8 (12)</td><td>81.9 (13)</td><td>73.4 (15)</td><td>68.3 (8)</td><td>4.1 (18)</td><td>57.3 (19)</td><td>85 (14)</td></tr>
          <tr><td>CONCH&nbsp;1.5</td><td>Histopathology</td><td>VLM</td><td>79.9 (7)</td><td>82.4 (12)</td><td>75.0 (10)</td><td>68.8 (5)</td><td>4.6 (22)</td><td>75.8 (30)</td><td>86 (15)</td></tr>
          <tr><td>KEEP</td><td>Histopathology</td><td>VLM</td><td>81.5 (4)</td><td>83.2 (9)</td><td>77.1 (4)</td><td>68.0 (9)</td><td>4.0 (14)</td><td>44.9 (15)</td><td>55 (7)</td></tr>
          <tr><td>MUSK</td><td>Histopathology</td><td>VLM</td><td>77.7 (16)</td><td>81.1 (17)</td><td>71.9 (16)</td><td>65.1 (17)</td><td>4.0 (15)</td><td>71.9 (29)</td><td>110 (19)</td></tr>
          <tr><td>PLIP</td><td>Histopathology</td><td>VLM</td><td>70.2 (25)</td><td>74.0 (27)</td><td>64.1 (23)</td><td>58.5 (29)</td><td>4.5 (21)</td><td>60.8 (21)</td><td>146 (25)</td></tr>
          <tr><td>QUILTNET</td><td>Histopathology</td><td>VLM</td><td>70.4 (24)</td><td>73.9 (28)</td><td>65.6 (21)</td><td>58.9 (28)</td><td>5.8 (30)</td><td>55.6 (18)</td><td>149 (28)</td></tr>
          <tr><td>DINOv2-B</td><td>Natural-image</td><td>VM</td><td>69.0 (27)</td><td>76.6 (24)</td><td>60.2 (25)</td><td>59.8 (26)</td><td>5.0 (28)</td><td>66.1 (24)</td><td>154 (29)</td></tr>
          <tr><td>DINOv2-L</td><td>Natural-image</td><td>VM</td><td>70.6 (23)</td><td>77.0 (23)</td><td>58.7 (26)</td><td>59.6 (27)</td><td>4.9 (26)</td><td>64.4 (23)</td><td>148 (27)</td></tr>
          <tr><td>ViT-B/16</td><td>Natural-image</td><td>VM</td><td>66.2 (28)</td><td>74.7 (26)</td><td>57.3 (28)</td><td>61.0 (24)</td><td>4.0 (17)</td><td>47.0 (16)</td><td>139 (24)</td></tr>
          <tr><td>ViT-L/16</td><td>Natural-image</td><td>VM</td><td>69.3 (26)</td><td>75.5 (25)</td><td>56.9 (29)</td><td>63.1 (21)</td><td>4.3 (19)</td><td>43.9 (14)</td><td>134 (23)</td></tr>
          <tr><td>CLIP-B/32</td><td>Natural-image</td><td>VLM</td><td>63.0 (30)</td><td>68.8 (30)</td><td>52.3 (30)</td><td>56.0 (30)</td><td>4.9 (25)</td><td>63.6 (22)</td><td>167 (30)</td></tr>
          <tr><td>CLIP-L/14</td><td>Natural-image</td><td>VLM</td><td>65.7 (29)</td><td>73.6 (29)</td><td>58.1 (27)</td><td>60.8 (25)</td><td>3.8 (9)</td><td>70.5 (28)</td><td>147 (26)</td></tr>
          <tr><td>DINOv3-B</td><td>Natural-image</td><td>VM</td><td>70.6 (22)</td><td>77.4 (21)</td><td>64.8 (22)</td><td>63.4 (20)</td><td>3.7 (7)</td><td>70.1 (27)</td><td>119 (22)</td></tr>
          <tr><td>DINOv3-S</td><td>Natural-image</td><td>VM</td><td>72.0 (20)</td><td>77.1 (22)</td><td>65.7 (20)</td><td>62.0 (23)</td><td>2.8 (1)</td><td>66.9 (25)</td><td>111 (20)</td></tr>
          <tr><td>DINOv3-L</td><td>Natural-image</td><td>VM</td><td>71.5 (21)</td><td>77.9 (20)</td><td>61.8 (24)</td><td>62.6 (22)</td><td>3.0 (3)</td><td>68.9 (26)</td><td>116 (21)</td></tr>
          <tr><td>GIGAPATH</td><td>Histopathology</td><td>VM</td><td>79.5 (10)</td><td>82.9 (10)</td><td>75.5 (8)</td><td>63.5 (19)</td><td>3.4 (5)</td><td>42.1 (10)</td><td>62 (9)</td></tr>
          <tr><td>KAIKO-S/16</td><td>Histopathology</td><td>VM</td><td>78.2 (15)</td><td>81.7 (14)</td><td>75.1 (9)</td><td>66.8 (15)</td><td>4.6 (23)</td><td>42.5 (11)</td><td>87 (16)</td></tr>
          <tr><td>KAIKO-B/16</td><td>Histopathology</td><td>VM</td><td>78.7 (13)</td><td>81.4 (15)</td><td>76.4 (5)</td><td>66.8 (14)</td><td>5.0 (27)</td><td>38.8 (7)</td><td>81 (13)</td></tr>
          <tr><td>H0-mini</td><td>Histopathology</td><td>VM</td><td>79.7 (9)</td><td>83.8 (6)</td><td>75.0 (11)</td><td>69.1 (3)</td><td>3.8 (10)</td><td>34.3 (4)</td><td>43 (3)</td></tr>
      <tbody>
    </table>
</div>

---

## 🏆 Original (paper) Rank-sum Leaderboard

This leaderboard exactly reproduces the rank-sum table (Table 4) presented in our original [paper](https://arxiv.org/abs/2507.07860). 

<div class="table-responsive-sm">
  <table id="ranksumTableOriginal" class="table table-hover table-bordered table-sm nowrap">
    <thead class="align-middle text-center">
      <tr>
        <th>Model</th>
        <th>Domain</th>
        <th>Type</th>
        <th>KNN &uarr;</th>
        <th>Lin. prob. &uarr;</th>
        <th>Few-shot &uarr;</th>
        <th>Seg.&uarr;</th>
        <th>Calib. &darr;</th>
        <th>Adv. attack &darr;</th>
        <th>Rank sum &darr;</th>
      </tr>
    </thead>
    <tbody>
      <tr><td>HIBOU-B</td><td>Histopathology</td><td>VM</td><td>75.8 (10)</td><td>78.0 (14)</td><td>74.2 (6)</td><td>67.8 (10)</td><td>3.7 (2)</td><td>52.8 (14)</td><td>56 (7)</td></tr>
      <tr><td>HIBOU-L</td><td>Histopathology</td><td>VM</td><td>75.2 (12)</td><td>81.2 (7)</td><td>70.4 (12)</td><td>68.6 (6)</td><td>5.5 (18)</td><td>40.0 (5)</td><td>60 (8)</td></tr>
      <tr><td>H-OPTIMUS-0</td><td>Histopathology</td><td>VM</td><td>79.2 (5)</td><td>81.4 (5)</td><td>73.4 (7)</td><td>65.2 (13)</td><td>4.7 (13)</td><td>44.2 (9)</td><td>52 (6)</td></tr>
      <tr><td>H-OPTIMUS-1</td><td>Histopathology</td><td>VM</td><td>80.5 (3)</td><td>83.3 (2)</td><td>74.8 (4)</td><td>64.5 (15)</td><td>4.1 (4)</td><td>58.0 (17)</td><td>45 (5)</td></tr>
      <tr><td>MIDNIGHT</td><td>Histopathology</td><td>VM</td><td>78.2 (8)</td><td>82.9 (3)</td><td>70.6 (11)</td><td>68.8 (4)</td><td>3.2 (1)</td><td>36.3 (4)</td><td>31 (3)</td></tr>
      <tr><td>PHIKON</td><td>Histopathology</td><td>VM</td><td>72.8 (14)</td><td>78.4 (13)</td><td>72.2 (10)</td><td>68.0 (9)</td><td>6.4 (22)</td><td>34.4 (3)</td><td>71 (11)</td></tr>
      <tr><td>PHIKON2</td><td>Histopathology</td><td>VM</td><td>70.1 (15)</td><td>76.5 (15)</td><td>70.1 (13)</td><td>67.4 (12)</td><td>4.6 (11)</td><td>45.6 (11)</td><td>77 (12)</td></tr>
      <tr><td>UNI</td><td>Histopathology</td><td>VM</td><td>78.8 (6)</td><td>81.3 (6)</td><td>76.4 (2)</td><td>67.8 (11)</td><td>4.3 (7)</td><td>42.8 (7)</td><td>39 (4)</td></tr>
      <tr><td>UNI2-H</td><td>Histopathology</td><td>VM</td><td>81.7 (1)</td><td>83.9 (1)</td><td>78.4 (1)</td><td>69.0 (3)</td><td>4.5 (8)</td><td>34.3 (2)</td><td>16 (1)</td></tr>
      <tr><td>VIRCHOW</td><td>Histopathology</td><td>VM</td><td>74.2 (13)</td><td>80.2 (10)</td><td>68.5 (15)</td><td>69.2 (2)</td><td>5.5 (20)</td><td>41.0 (6)</td><td>66 (10)</td></tr>
      <tr><td>VIRCHOW2</td><td>Histopathology</td><td>VM</td><td>81.2 (2)</td><td>82.7 (4)</td><td>72.6 (9)</td><td>69.3 (1)</td><td>4.6 (10)</td><td>33.6 (1)</td><td>27 (2)</td></tr>
      <tr><td>CONCH</td><td>Histopathology</td><td>VLM</td><td>77.3 (9)</td><td>80.2 (11)</td><td>73.1 (8)</td><td>68.3 (7)</td><td>4.3 (6)</td><td>55.0 (15)</td><td>56 (7)</td></tr>
      <tr><td>CONCH&nbsp;1.5</td><td>Histopathology</td><td>VLM</td><td>78.6 (7)</td><td>80.8 (9)</td><td>74.6 (5)</td><td>68.8 (5)</td><td>4.9 (14)</td><td>75.3 (23)</td><td>63 (9)</td></tr>
      <tr><td>KEEP</td><td>Histopathology</td><td>VLM</td><td>79.7 (4)</td><td>81.1 (8)</td><td>75.8 (3)</td><td>68.0 (8)</td><td>4.7 (12)</td><td>44.7 (10)</td><td>45 (5)</td></tr>
      <tr><td>MUSK</td><td>Histopathology</td><td>VLM</td><td>75.6 (11)</td><td>79.0 (12)</td><td>70.0 (14)</td><td>65.1 (14)</td><td>4.5 (9)</td><td>69.3 (22)</td><td>82 (13)</td></tr>
      <tr><td>PLIP</td><td>Histopathology</td><td>VLM</td><td>67.8 (19)</td><td>71.0 (22)</td><td>63.4 (17)</td><td>58.5 (22)</td><td>4.9 (15)</td><td>56.9 (16)</td><td>111 (18)</td></tr>
      <tr><td>QUILTNET</td><td>Histopathology</td><td>VLM</td><td>68.3 (17)</td><td>71.0 (21)</td><td>65.7 (16)</td><td>58.9 (21)</td><td>7.0 (23)</td><td>52.7 (13)</td><td>111 (18)</td></tr>
      <tr><td>DINOv2-B</td><td>Natural-image</td><td>VM</td><td>67.9 (18)</td><td>74.8 (17)</td><td>61.0 (18)</td><td>59.8 (19)</td><td>5.5 (21)</td><td>65.8 (20)</td><td>113 (19)</td></tr>
      <tr><td>DINOv2-L</td><td>Natural-image</td><td>VM</td><td>69.6 (16)</td><td>75.3 (16)</td><td>59.2 (19)</td><td>59.6 (20)</td><td>5.3 (17)</td><td>64.5 (19)</td><td>107 (17)</td></tr>
      <tr><td>ViT-B/16</td><td>Natural-image</td><td>VM</td><td>64.4 (21)</td><td>71.9 (19)</td><td>57.8 (21)</td><td>61.0 (17)</td><td>3.9 (3)</td><td>46.8 (12)</td><td>93 (14)</td></tr>
      <tr><td>ViT-L/16</td><td>Natural-image</td><td>VM</td><td>67.5 (20)</td><td>72.8 (18)</td><td>56.5 (22)</td><td>63.1 (16)</td><td>5.0 (16)</td><td>44.1 (8)</td><td>100 (15)</td></tr>
      <tr><td>CLIP-B/32</td><td>Natural-image</td><td>VLM</td><td>61.9 (23)</td><td>65.8 (23)</td><td>53.3 (23)</td><td>56.0 (23)</td><td>5.5 (19)</td><td>60.4 (18)</td><td>129 (23)</td></tr>
      <tr><td>CLIP-L/14</td><td>Natural-image</td><td>VLM</td><td>64.2 (22)</td><td>71.3 (20)</td><td>58.2 (20)</td><td>60.8 (18)</td><td>4.2 (5)</td><td>67.8 (21)</td><td>106 (16)</td></tr>
    </tbody>
  </table>
</div>

---

## 🏆 SPIDER Leaderboard

F1-score on test sets of SPIDER datasets and average across datasets for the *knn* and *linear probing* tasks. The considered datasets are:

* *Br*: [SPIDER-Breast](https://huggingface.co/datasets/histai/SPIDER-breast)
* *Co*: [SPIDER-Colorectal](https://huggingface.co/datasets/histai/SPIDER-colorectal)
* *Sk*: [SPIDER-skin](https://huggingface.co/datasets/histai/SPIDER-skin)
* *Th*: [SPIDER-thorax](https://huggingface.co/datasets/histai/SPIDER-thorax)

<div class="table-responsive-sm">
    <table id="spiderTable" class="table table-hover table-bordered table-sm nowrap">
        <thead class="align-middle text-center">
          <tr>
            <th rowspan="2">Model</th>
            <th rowspan="2">Domain</th>
            <th rowspan="2">Type</th>
            <th colspan="5">KNN &uarr;</th>
            <th colspan="5">Linear probing &uarr;</th>
          </tr>
          <tr>
            <th>Br</th><th>Co</th><th>Sk</th><th>Th</th><th>Avg</th>
            <th>Br</th><th>Co</th><th>Sk</th><th>Th</th><th>Avg</th>
          </tr>
      </thead>
        <tbody>
          <tr><td>HIBOU-B</td><td>Histopathology</td><td>VM</td><td>83.3 (2)</td><td>88.1 (2)</td><td>87.7 (7)</td><td>93.4 (3)</td><td>88.1 (5)</td><td>86.6 (5)</td><td>90.7 (2)</td><td>91.1 (9)</td><td>94.5 (4)</td><td>90.7 (5)</td></tr>
          <tr><td>HIBOU-L</td><td>Histopathology</td><td>VM</td><td>83.6 (1)</td><td>88.1 (1)</td><td>90.7 (2)</td><td>93.5 (2)</td><td>89.0 (1)</td><td>88.0 (1)</td><td>89.8 (10)</td><td>93.3 (1)</td><td>94.1 (7)</td><td>91.3 (1)</td></tr>
          <tr><td>H-OPTIMUS-0</td><td>Histopathology</td><td>VM</td><td>81.7 (6)</td><td>87.8 (7)</td><td>89.3 (4)</td><td>93.8 (1)</td><td>88.2 (3)</td><td>87.2 (3)</td><td>89.9 (9)</td><td>91.9 (5)</td><td>94.4 (5)</td><td>90.8 (4)</td></tr>
          <tr><td>H0-mini</td><td>Histopathology</td><td>VM</td><td>80.9 (9)</td><td>88.0 (5)</td><td>86.2 (11)</td><td>92.8 (5)</td><td>87.0 (9)</td><td>86.0 (9)</td><td>90.2 (7)</td><td>90.4 (11)</td><td>93.4 (13)</td><td>90.0 (11)</td></tr>
          <tr><td>H-OPTIMUS-1</td><td>Histopathology</td><td>VM</td><td>83.0 (3)</td><td>87.8 (6)</td><td>91.1 (1)</td><td>91.5 (13)</td><td>88.4 (2)</td><td>86.1 (7)</td><td>90.3 (6)</td><td>92.3 (3)</td><td>93.6 (12)</td><td>90.6 (6)</td></tr>
          <tr><td>KAIKO--S/16</td><td>Histopathology</td><td>VM</td><td>76.8 (17)</td><td>85.4 (14)</td><td>82.4 (18)</td><td>92.7 (7)</td><td>84.3 (15)</td><td>83.1 (15)</td><td>88.4 (16)</td><td>88.6 (13)</td><td>93.1 (16)</td><td>88.3 (15)</td></tr>
          <tr><td>KAIKO--B/16</td><td>Histopathology</td><td>VM</td><td>77.8 (14)</td><td>85.3 (15)</td><td>82.5 (16)</td><td>92.0 (12)</td><td>84.4 (14)</td><td>81.9 (17)</td><td>88.5 (14)</td><td>87.4 (16)</td><td>93.3 (15)</td><td>87.8 (16)</td></tr>
          <tr><td>MIDNIGHT</td><td>Histopathology</td><td>VM</td><td>77.1 (16)</td><td>84.9 (17)</td><td>85.7 (12)</td><td>92.7 (6)</td><td>85.1 (13)</td><td>86.1 (8)</td><td>89.6 (13)</td><td>91.0 (10)</td><td>94.4 (6)</td><td>90.3 (9)</td></tr>
          <tr><td>PHIKON</td><td>Histopathology</td><td>VM</td><td>78.9 (13)</td><td>85.1 (16)</td><td>83.2 (15)</td><td>89.7 (19)</td><td>84.3 (16)</td><td>84.9 (14)</td><td>88.5 (15)</td><td>87.9 (14)</td><td>92.4 (17)</td><td>88.4 (14)</td></tr>
          <tr><td>PHIKON2</td><td>Histopathology</td><td>VM</td><td>80.2 (10)</td><td>86.5 (12)</td><td>83.3 (13)</td><td>91.4 (15)</td><td>85.3 (12)</td><td>86.0 (10)</td><td>89.7 (12)</td><td>87.2 (18)</td><td>94.7 (3)</td><td>89.4 (13)</td></tr>
          <tr><td>GIGAPATH</td><td>Histopathology</td><td>VM</td><td>81.5 (7)</td><td>87.4 (9)</td><td>86.9 (10)</td><td>92.4 (10)</td><td>87.0 (7)</td><td>85.5 (13)</td><td>90.3 (5)</td><td>91.3 (7)</td><td>93.8 (11)</td><td>90.2 (10)</td></tr>
          <tr><td>UNI</td><td>Histopathology</td><td>VM</td><td>81.3 (8)</td><td>88.0 (3)</td><td>87.2 (8)</td><td>91.2 (16)</td><td>86.9 (11)</td><td>85.7 (11)</td><td>90.4 (4)</td><td>91.2 (8)</td><td>93.9 (9)</td><td>90.3 (8)</td></tr>
          <tr><td>UNI2-H</td><td>Histopathology</td><td>VM</td><td>82.6 (4)</td><td>87.1 (11)</td><td>90.5 (3)</td><td>92.5 (9)</td><td>88.2 (4)</td><td>86.7 (4)</td><td>90.5 (3)</td><td>92.5 (2)</td><td>95.1 (1)</td><td>91.2 (2)</td></tr>
          <tr><td>VIRCHOW</td><td>Histopathology</td><td>VM</td><td>79.3 (12)</td><td>87.8 (8)</td><td>88.8 (6)</td><td>92.3 (11)</td><td>87.0 (8)</td><td>86.2 (6)</td><td>90.2 (8)</td><td>91.3 (6)</td><td>94.7 (2)</td><td>90.6 (7)</td></tr>
          <tr><td>VIRCHOW2</td><td>Histopathology</td><td>VM</td><td>82.3 (5)</td><td>88.0 (4)</td><td>89.1 (5)</td><td>92.6 (8)</td><td>88.0 (6)</td><td>87.2 (2)</td><td>90.8 (1)</td><td>92.0 (4)</td><td>93.9 (8)</td><td>91.0 (3)</td></tr>
          <tr><td>CONCH</td><td>Histopathology</td><td>VLM</td><td>75.1 (19)</td><td>84.5 (18)</td><td>81.7 (19)</td><td>91.1 (17)</td><td>83.1 (19)</td><td>82.1 (16)</td><td>87.9 (18)</td><td>87.3 (17)</td><td>91.0 (19)</td><td>87.1 (18)</td></tr>
          <tr><td>CONCH&nbsp;1.5</td><td>Histopathology</td><td>VLM</td><td>75.9 (18)</td><td>84.2 (19)</td><td>83.3 (14)</td><td>91.4 (14)</td><td>83.7 (18)</td><td>81.6 (18)</td><td>87.4 (19)</td><td>87.0 (19)</td><td>92.1 (18)</td><td>87.0 (19)</td></tr>
          <tr><td>KEEP</td><td>Histopathology</td><td>VLM</td><td>79.8 (11)</td><td>87.2 (10)</td><td>87.2 (9)</td><td>93.1 (4)</td><td>86.9 (10)</td><td>85.6 (12)</td><td>89.7 (11)</td><td>89.3 (12)</td><td>93.8 (10)</td><td>89.6 (12)</td></tr>
          <tr><td>MUSK</td><td>Histopathology</td><td>VLM</td><td>77.2 (15)</td><td>85.7 (13)</td><td>82.5 (17)</td><td>91.1 (18)</td><td>84.1 (17)</td><td>80.6 (19)</td><td>87.9 (17)</td><td>87.6 (15)</td><td>93.3 (14)</td><td>87.4 (17)</td></tr>
          <tr><td>PLIP</td><td>Histopathology</td><td>VLM</td><td>69.4 (21)</td><td>79.9 (20)</td><td>74.4 (20)</td><td>86.4 (20)</td><td>77.5 (20)</td><td>77.1 (23)</td><td>84.7 (25)</td><td>82.1 (21)</td><td>88.6 (22)</td><td>83.1 (23)</td></tr>
          <tr><td>QUILTNET</td><td>Histopathology</td><td>VLM</td><td>69.9 (20)</td><td>77.7 (26)</td><td>73.4 (22)</td><td>85.3 (21)</td><td>76.6 (21)</td><td>77.0 (24)</td><td>82.9 (28)</td><td>81.2 (27)</td><td>88.5 (24)</td><td>82.4 (26)</td></tr>
          <tr><td>DINOv2-B</td><td>Natural-image</td><td>VM</td><td>64.0 (27)</td><td>77.5 (27)</td><td>70.4 (27)</td><td>78.1 (27)</td><td>72.5 (27)</td><td>76.0 (26)</td><td>83.9 (27)</td><td>80.1 (28)</td><td>87.6 (28)</td><td>81.9 (28)</td></tr>
          <tr><td>DINOv2-L</td><td>Natural-image</td><td>VM</td><td>66.1 (25)</td><td>79.0 (23)</td><td>71.4 (26)</td><td>78.5 (26)</td><td>73.7 (26)</td><td>74.0 (28)</td><td>85.3 (21)</td><td>82.1 (22)</td><td>87.7 (27)</td><td>82.3 (27)</td></tr>
          <tr><td>ViT-B/16</td><td>Natural-image</td><td>VM</td><td>63.6 (28)</td><td>76.7 (28)</td><td>68.7 (28)</td><td>77.0 (29)</td><td>71.5 (28)</td><td>78.2 (22)</td><td>84.7 (26)</td><td>81.2 (26)</td><td>87.9 (26)</td><td>83.0 (24)</td></tr>
          <tr><td>ViT-L/16</td><td>Natural-image</td><td>VM</td><td>66.5 (24)</td><td>78.7 (25)</td><td>71.8 (25)</td><td>81.8 (22)</td><td>74.7 (24)</td><td>79.3 (20)</td><td>85.1 (22)</td><td>81.3 (25)</td><td>88.5 (23)</td><td>83.6 (21)</td></tr>
          <tr><td>DINOv3-B</td><td>Natural-image</td><td>VM</td><td>65.8 (26)</td><td>78.9 (24)</td><td>73.2 (23)</td><td>80.5 (25)</td><td>74.6 (25)</td><td>76.5 (25)</td><td>84.8 (24)</td><td>81.6 (24)</td><td>90.0 (21)</td><td>83.2 (22)</td></tr>
          <tr><td>DINOv3-L</td><td>Natural-image</td><td>VM</td><td>66.9 (22)</td><td>79.8 (21)</td><td>73.1 (24)</td><td>81.6 (23)</td><td>75.3 (23)</td><td>78.3 (21)</td><td>86.3 (20)</td><td>82.5 (20)</td><td>90.1 (20)</td><td>84.3 (20)</td></tr>
          <tr><td>DINOv3-S</td><td>Natural-image</td><td>VM</td><td>66.8 (23)</td><td>79.5 (22)</td><td>73.9 (21)</td><td>81.6 (24)</td><td>75.5 (22)</td><td>75.0 (27)</td><td>85.0 (23)</td><td>81.8 (23)</td><td>88.2 (25)</td><td>82.5 (25)</td></tr>
          <tr><td>CLIP-B/32</td><td>Natural-image</td><td>VLM</td><td>57.0 (30)</td><td>71.0 (30)</td><td>63.7 (30)</td><td>73.7 (30)</td><td>66.4 (30)</td><td>69.0 (30)</td><td>81.3 (30)</td><td>75.8 (30)</td><td>84.7 (30)</td><td>77.7 (30)</td></tr>
          <tr><td>CLIP-L/14</td><td>Natural-image</td><td>VLM</td><td>62.5 (29)</td><td>74.6 (29)</td><td>66.5 (29)</td><td>77.4 (28)</td><td>70.2 (29)</td><td>73.6 (29)</td><td>82.8 (29)</td><td>78.5 (29)</td><td>86.7 (29)</td><td>80.4 (29)</td></tr>
        <tbody>
    </table>
</div>

---

## 🏆 Zero-shot VLM Classification Leaderboard

F1-score on test sets of all supported datasets and average across datasets for the *zero-shot classification* task. Only VLM models with publicly released patch-level text encoders are included.

<div class="table-responsive-sm">
    <table id="zeroshotTable" class="table table-hover table-bordered table-sm nowrap pivot w-100" style="width:100%">
        <thead class="align-middle text-center">
          <tr>
            <th>Model</th>
            <th>Domain</th>
            <th>Type</th>
            <th>bach</th>
            <th>bracs</th>
            <th>break_his</th>
            <th>ccrcc</th>
            <th>crc</th>
            <th>esca</th>
            <th>mhist</th>
            <th>patch_camelyon</th>
            <th>tcga_crc_msi</th>
            <th>tcga_tils</th>
            <th>tcga_uniform</th>
            <th>wilds</th>
            <th>spider_breast</th>
            <th>spider_colorectal</th>
            <th>spider_skin</th>
            <th>spider_thorax</th>
            <th>Avg</th>
        </tr>
      </thead>
        <tbody>
          <tr><td>CONCH</td><td>Histopathology</td><td>VLM</td><td>56.1 (3)</td><td>37.9 (2)</td><td>53.6 (1)</td><td>56.9 (2)</td><td>51.8 (4)</td><td>40.1 (1)</td><td>60.8 (2)</td><td>57.8 (3)</td><td>21.6 (4)</td><td>47.4 (5)</td><td>37.9 (2)</td><td>83.2 (2)</td><td>30.7 (3)</td><td>31.4 (3)</td><td>35.1 (3)</td><td>43.0 (3)</td><td>46.6 (3)</td></tr>
          <tr><td>KEEP</td><td>Histopathology</td><td>VLM</td><td>63.4 (1)</td><td>34.2 (3)</td><td>45.0 (3)</td><td>69.1 (1)</td><td>80.6 (1)</td><td>33.3 (2)</td><td>41.3 (7)</td><td>71.4 (1)</td><td>15.5 (6)</td><td>55.5 (2)</td><td>44.9 (1)</td><td>89.4 (1)</td><td>37.7 (1)</td><td>44.4 (1)</td><td>60.7 (1)</td><td>51.8 (2)</td><td>52.4 (1)</td></tr>
          <tr><td>MUSK</td><td>Histopathology</td><td>VLM</td><td>62.5 (2)</td><td>38.6 (1)</td><td>52.6 (2)</td><td>50.7 (3)</td><td>57.9 (3)</td><td>25.9 (4)</td><td>63.8 (1)</td><td>53.5 (5)</td><td>22.7 (3)</td><td>50.1 (3)</td><td>32.4 (3)</td><td>71.2 (3)</td><td>36.3 (2)</td><td>36.2 (2)</td><td>48.5 (2)</td><td>55.2 (1)</td><td>47.4 (2)</td></tr>
          <tr><td>PLIP</td><td>Histopathology</td><td>VLM</td><td>42.7 (4)</td><td>25.9 (5)</td><td>25.6 (5)</td><td>38.2 (5)</td><td>61.4 (2)</td><td>31.5 (3)</td><td>53.9 (5)</td><td>46.1 (7)</td><td>16.3 (5)</td><td>64.1 (1)</td><td>10.3 (5)</td><td>51.0 (6)</td><td>14.6 (4)</td><td>28.3 (4)</td><td>23.5 (4)</td><td>22.6 (4)</td><td>34.7 (4)</td></tr>
          <tr><td>QUILTNET</td><td>Histopathology</td><td>VLM</td><td>30.3 (5)</td><td>29.1 (4)</td><td>37.5 (4)</td><td>24.2 (6)</td><td>44.2 (5)</td><td>14.2 (5)</td><td>57.1 (4)</td><td>65.8 (2)</td><td>50.4 (1)</td><td>47.6 (4)</td><td>12.3 (4)</td><td>44.3 (7)</td><td>13.9 (5)</td><td>25.0 (5)</td><td>18.5 (5)</td><td>19.7 (5)</td><td>33.4 (5)</td></tr>
          <tr><td>CLIP-B/32</td><td>Natural-image</td><td>VLM</td><td>13.2 (7)</td><td>7.5 (7)</td><td>18.7 (6)</td><td>21.8 (7)</td><td>24.4 (7)</td><td>9.8 (7)</td><td>42.2 (6)</td><td>48.1 (6)</td><td>13.9 (7)</td><td>21.6 (7)</td><td>2.0 (7)</td><td>56.8 (5)</td><td>3.9 (7)</td><td>6.1 (7)</td><td>4.3 (7)</td><td>5.5 (6)</td><td>18.7 (7)</td></tr>
          <tr><td>CLIP-L/14</td><td>Natural-image</td><td>VLM</td><td>27.1 (6)</td><td>19.2 (6)</td><td>5.8 (7)</td><td>40.6 (4)</td><td>41.1 (6)</td><td>10.4 (6)</td><td>58.0 (3)</td><td>55.6 (4)</td><td>49.4 (2)</td><td>25.4 (6)</td><td>7.4 (6)</td><td>70.2 (4)</td><td>7.3 (6)</td><td>16.0 (6)</td><td>6.6 (6)</td><td>5.4 (7)</td><td>27.8 (6)</td></tr>
        <tbody>
    </table>
</div>
