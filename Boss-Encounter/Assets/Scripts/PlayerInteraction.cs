using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInteraction : MonoBehaviour
{
    // Start is called before the first frame update
    public KeyCode interactKey = KeyCode.E;
    private ButtonController currentButton;

    private void OnTriggerEnter(Collider other)
    {
        ButtonController button = other.GetComponent<ButtonController>();
        if (button != null)
        {
            currentButton = button;
            UIManager.Instance.ShowInteractionPrompt($"Press [{interactKey}] to activate lasers");
        }
    }
    void Start()
    {
        
    }
    private void OnTriggerExit(Collider other)
    {
        ButtonController button = other.GetComponent<ButtonController>();
        if (button != null && button == currentButton)
        {
            currentButton = null;
            UIManager.Instance.HideInteractionPrompt();
        }
    }
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(interactKey) && currentButton != null)
        {
            currentButton.OnPress();
        }
    }
}
