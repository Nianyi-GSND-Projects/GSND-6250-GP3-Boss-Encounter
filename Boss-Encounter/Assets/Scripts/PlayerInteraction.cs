using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInteraction : MonoBehaviour
{
    // Start is called before the first frame update
    public KeyCode interactKey = KeyCode.E;

    private void OnTriggerStay(Collider other)
    {
        if (Input.GetKeyDown(interactKey))
        {
            ButtonController button =  other.GetComponent<ButtonController>();
            if (button)
            {
                button.OnPress();
            }
        }
    }
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
