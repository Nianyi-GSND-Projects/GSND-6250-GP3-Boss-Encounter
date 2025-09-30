using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class CameraTrigger : MonoBehaviour
{
    private Light[] spotlights;
    
    public UnityEvent OnPlayerEnter;

    private void Awake()
    {
        spotlights = GetComponentsInChildren<Light>();
        SetSpotlights(false);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            SetSpotlights(true);
            OnPlayerEnter.Invoke();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            SetSpotlights(false);
        }
    }

    private void SetSpotlights(bool state)
    {
        if (spotlights != null)
        {
            foreach (Light spot in spotlights)
                {
                spot.enabled = state;
                }
        }
    }

    private void OnDrawGizmos()
    {
        BoxCollider box = GetComponent<BoxCollider>();
        if (box != null)
        {
            Gizmos.color = Color.red;
            Gizmos.matrix = transform.localToWorldMatrix;
            Gizmos.DrawWireCube(box.bounds.center, box.bounds.size);
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
