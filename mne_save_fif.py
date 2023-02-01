#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Create *raw.fif file with MNE-Python to be linked in Brainstorm

Raymundo Cassani, 2022
"""

import mne
import numpy as np

# Parameters
fs = 600       # Hz
duration = 3   # s
n_channels = 3
ch_names = ['MEG_' + str(i_ch + 1) for i_ch in range(n_channels)]
ch_types = ['mag']  * n_channels

# Signals
time_vector = np.arange(np.round(fs * duration)) / fs
data = np.zeros([n_channels, len(time_vector)])
for i_ch in range(n_channels):
    # Sine wave with frequency (i_ch + 1) Hz
    data[i_ch, :] = np.sin(2 * np.pi * (i_ch + 1) * time_vector)
# Scale data to fT
data = data / 1e15

# Info
info = mne.create_info(ch_names, fs, ch_types)

# Save as .fif 
raw = mne.io.RawArray(data, info)
raw.save('test_raw.fif')
