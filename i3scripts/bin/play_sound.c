// gcc -o play_sound play_sound.c -lasound -lm

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <alsa/asoundlib.h> // ALSA kütüphanesi

#define SAMPLE_RATE 44100
#define PI 3.14159265

// Fonksiyon prototipi
double generateSample(double frequency, double time);

int main(int argc, char *argv[]) {
    if (argv[1] == NULL) {
        fprintf(stderr, "argv[1] -> frequency\n");
        return (1);
    }
    double frequency;
    if (argv[2] == NULL) {
        fprintf(stderr, "argv[2] -> time\n");
        return (1);
    }
    double duration;
    int err;
    unsigned int sample_rate = SAMPLE_RATE;
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    // snd_pcm_uframes_t frames;
    int dir;
    short *buffer;
    frequency = (double) strtod(argv[1], NULL); // A4 nota frekansı (440 Hz)
    duration = (double)  strtod(argv[2], NULL);
    if (duration <= 0 || duration > 5) {
        fprintf(stderr, "Duration must be <= 5 and > 0.\n");
        duration = 3.0;
        fprintf(stderr, "Duration is set to default value. (3 seconds)\n");
    }
    double num_samples = duration * SAMPLE_RATE;
    double volume = 32767.0;
    double volume_ratio;
    if (argv[3] == NULL) {
        fprintf(stderr, "argv[3] -> volume [0 - 10] default 5\n");
        return (1);
    }
    volume_ratio = strtod(argv[3], NULL);
    printf("<<%f\n", volume_ratio / 10);
    if (volume_ratio < 0 || volume_ratio > 10) {
        fprintf(stderr, "Volume must be >= 0 and <= 10\n");
        volume_ratio = 5;
        fprintf(stderr, "Volume is set to default value. (0.5)");
    }
    buffer = (short *)malloc(num_samples * sizeof(short));
    for (int i = 0; i < (int)num_samples; i++) {
        buffer[i] = (short)(generateSample(
                    frequency,
                    (double)i / SAMPLE_RATE) * (volume * (volume_ratio / 10)));
    }

    /* Open PCM device for playback. */
    err = snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (err < 0) {
        fprintf(stderr, "Unable to open PCM device: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
    }

    /* Allocate parameters object and fill it with default values. */
    snd_pcm_hw_params_alloca(&params);

    snd_pcm_hw_params_any(handle, params);

    /*
     * Set parameters:
     * interleaved mode,
     * 16-bit little-endian format,
     * 1 channel (mono),
     * and SAMPLE_RATE sample rate
     */
    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(handle, params, 1);
    snd_pcm_hw_params_set_rate_near(handle, params, &sample_rate, &dir);

    /* Write parameters to the driver */
    err = snd_pcm_hw_params(handle, params);
    if (err < 0) {
        fprintf(stderr, "Unable to set HW parameters: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
    }

    /* Write the data to the device */
    err = snd_pcm_writei(handle, buffer, num_samples);
    if (err != num_samples) {
        fprintf(stderr, "Write to PCM device failed: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
    }

    /* Stop PCM device and close the handle */
    snd_pcm_drain(handle);
    snd_pcm_close(handle);
    free(buffer);

    fprintf(stderr, "Ses calma islemi tamamlandi.\n");

    return (0);
}

// Ses örneği üreten fonksiyon
double generateSample(double frequency, double time) {
    return sin(2 * PI * frequency * time);
}

