using System.Collections;
using UnityEngine;
using TMPro;

public class UIManager : MonoBehaviour
{
    public static UIManager Instance { get; private set; }

    [Header("UI References")]
    public TextMeshProUGUI temporaryNotificationText;
    public TextMeshProUGUI interactionPromptText;

    public GameObject monologuePanel;

    public TextMeshProUGUI monologueText;

    [Header("Settings")]
    public float notificationDisplayTime = 2f;
    public float displaytime = 10f;
    private Coroutine notificationCoroutine;
    private Coroutine monologueCoroutine;






    void Awake()
    {
       
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        else
        {
            Instance = this;
        }
    }

    void Start()
    {
        if (UIManager.Instance != null)
        {
            StartCoroutine(OpenSceneMonologue());
        }
    }
    private IEnumerator OpenSceneMonologue()
    {
        yield return new WaitForSeconds(1.0f);
        yield return StartCoroutine(MonologueRoutine("Hacker : Our goal is to get that great diamond!"));
        yield return new WaitForSeconds(0.5f);
        yield return StartCoroutine(MonologueRoutine("Hacker: I have already had their security cameras down! "));
    }
    public void ShowNotification(string message)
    {
        if (notificationCoroutine != null)
        {
            StopCoroutine(notificationCoroutine);
        }
        notificationCoroutine = StartCoroutine(NotificationRoutine(message));
    }
    public void ShowBossEncounterMonologue()
    {
        StartCoroutine(BossEncounterMonologueSequence());
    }
    private IEnumerator BossEncounterMonologueSequence()
    {
        ShowNotification("Warning!! Unverified Visitors!");
        yield return new WaitForSeconds(0.5f);
        yield return StartCoroutine(MonologueRoutine("Hacker : Wait what? They have emergency power supply!"));
        ShowNotification("Please use the laser defence system to eliminate intruders.");
    }
    private IEnumerator NotificationRoutine(string message)
    {
        temporaryNotificationText.text = message;
        temporaryNotificationText.gameObject.SetActive(true);
        yield return new WaitForSeconds(notificationDisplayTime);
        temporaryNotificationText.gameObject.SetActive(false);
    }

    public void ShowInteractionPrompt(string message)
    {
        if (interactionPromptText == null) return;
        interactionPromptText.text = message;
        interactionPromptText.gameObject.SetActive(true);
    }

    public void HideInteractionPrompt()
    {
        if (interactionPromptText == null) return;
        interactionPromptText.gameObject.SetActive(false);
    }



    private IEnumerator MonologueRoutine(string message)
    {
        monologueText.text = message;
        monologuePanel.SetActive(true);
        yield return new WaitForSeconds(displaytime);
        monologuePanel.SetActive(false);
    }
    
}