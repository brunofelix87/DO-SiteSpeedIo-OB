module.exports = async function (context, commands) {
    await commands.navigate(
        'https://myhotel-html5-qa.omnibees.test/'
    );
    try {
        // Add text into an input field y finding the field by id
        await commands.addText.byId('qa', 'username');
        await commands.addText.byId('protur2012', 'password');

        // find the sumbit button and click it
        await commands.click.byIdAndWait('btn-start-session');

        // we wait for something on the page that verifies that we are logged in
        return commands.wait.byId('appRoot', 3000);

    } catch (e) {
        throw e;
    }
};