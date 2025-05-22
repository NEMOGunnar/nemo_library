import streamlit as st
from streamlit_option_menu import option_menu
from nemo_library import NemoLibrary

# Initialize session state
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False
if "nemo_library" not in st.session_state:
    st.session_state.nemo_library = None


def login():
    st.title("Login")

    with st.form("login_form"):
        environment = st.selectbox(
            "Select Environment",
            ("prod", "test", "dev", "challenge", "demo"),
            index=0,
        )
        tenant = st.text_input("Tenant", value="mig")
        userid = st.text_input("Username", value="schug_g_mig")
        password = st.text_input("Password", type="password")
        submitted = st.form_submit_button("Login")

        if submitted:
            nl = NemoLibrary(
                environment=environment,
                tenant=tenant,
                userid=userid,
                password=password,
            )

            nl.testLogin()
            st.session_state.logged_in = True
            st.session_state.nemo_library = nl
            st.success("Login successful!")

            # Force re-run to reload UI based on new login state
            st.rerun()


# Show login form or main app
if not st.session_state.logged_in:
    login()
else:

    # Title bar of the application
    st.title("User Interface for NEMO Library")
    st.markdown(
        "This is a user interface for the NEMO library, allowing users to interact with NEMO's functionalities."
    )

    with st.sidebar:
        st.markdown(
            f"**Version:** {NemoLibrary.__version__}"
        )  # Display version in the sidebar
